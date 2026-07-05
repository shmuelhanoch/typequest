(defn clear-screen []
  (prin "\e[2J\e[H"))

(defn play-chunk [target chunk-num total-chunks]
  (var cursor 0)
  (var total-errors 0)
  (var start-time nil)
  (var input-buffer @"")
  
  (clear-screen)
  (print "=========================================================")
  (print " TypeQuest — Paragraph " chunk-num " of " total-chunks)
  (print "=========================================================\n")
  (print target "\n")
  
  # Switch terminal to raw mode to read char-by-char instantly
  (os/execute ["stty" "raw" "-echo"] :p)
  
  (defer (os/execute ["stty" "sane"] :p)
    (while (< cursor (length target))
      (prin "\r\e[K") 
      (prin "\e[32m" (string input-buffer) "\e[0m")
      (prin "\e[90m" (string/slice target cursor) "\e[0m")
      
      (let [raw-input (file/read stdin 1)
            # FIX: Cast the mutable buffer explicitly to a string for stable comparison
            ch (if raw-input (string raw-input) "")
            expected (string/slice target cursor (+ cursor 1))
            is-backspace (or (= ch "\x7f") (= ch "\x08"))]
        
        (when (nil? start-time)
          (set start-time (os/clock)))
        
        (cond
          # Ctrl+C now triggers flawlessly
          (= ch "\x03") 
          (do 
            (os/execute ["stty" "sane"] :p)
            (clear-screen)
            (print "=========================================================")
            (print "  👋 Exiting TypeQuest. Safe travels out there!")
            (print "=========================================================\n")
            (os/exit 0))
          
          (and is-backspace (> (length input-buffer) cursor))
          :nil
          
          (and (= ch expected) (= (length input-buffer) cursor))
          (do
            (buffer/push-string input-buffer ch)
            (set cursor (+ cursor 1)))
          
          (and (not is-backspace) (= (length input-buffer) cursor))
          (do
            (set total-errors (+ total-errors 1))
            (prin "\e[31m" expected "\e[0m\x08"))))))
          
  # Reset terminal immediately after loop breaks so calculations can print cleanly
  (os/execute ["stty" "sane"] :p)
  
  (let [end-time (os/clock)
        elapsed-secs (if (nil? start-time) 0.001 (- end-time start-time))
        elapsed-mins (/ elapsed-secs 60.0)
        chars-typed (length target)
        raw-wpm (math/round (/ (/ chars-typed 5.0) elapsed-mins))
        accuracy (math/round (* (/ chars-typed (+ chars-typed total-errors)) 100.0))]
        
    (print "\n\n---------------------------------------------------------")
    (print " 📊 PERFORMANCE SCORECARD:")
    (print "    Speed:    " raw-wpm " WPM")
    (print "    Accuracy: " accuracy "%")
    (print "    Typos:    " total-errors)
    (print "---------------------------------------------------------")
    (print "\nPress any key to advance to the next paragraph...")
    (file/read stdin 1)))

(defn main [& args]
  (let [file-path (or (get args 1) "books/sample.txt")
        file-content (try (slurp file-path) ([err] nil))]
    
    (if (nil? file-content)
      (print "Error: Could not read file at " file-path)
      (do
        (let [paragraphs (string/split "\n\n" file-content)
              total (length paragraphs)]
          
          (loop [i :range [0 total]]
            (let [clean-paragraph (string/trim (get paragraphs i))]
              (when (> (length clean-paragraph) 0)
                (play-chunk clean-paragraph (+ i 1) total)))))
        
        (clear-screen)
        (print "=========================================================")
        (print " 🎉 Congratulations! You finished the entire file! 🎉")
        (print "=========================================================\n")))))
