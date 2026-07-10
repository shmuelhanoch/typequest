(declare-project
  :name "typequest"
  :description "A minimalist terminal typing coach"
  :dependencies ["https://github.com/MorganPeterson/jermbox"]) # or "jermbox"

(declare-executable
  :name "typequest"
  :entry "src/main.janet")

(task "dev" []
  (os/execute ["janet" "src/main.janet"] :p))
