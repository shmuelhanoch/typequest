(use judge)

(deftest "Sanity: Codebase compiles and modules resolve"
  # This attempts to parse and load your main entry point.
  # If there is a syntax error or a missing dependency, it will crash here.
  (assert (import src/main :as main) "Failed to import src/main.janet"))
