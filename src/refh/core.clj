(ns refh.core
  (:require [cljs.nodejs :as node]))

(defn -main
  "I don't do a whole lot."
  [& args]
  (println "Hello, World!"))

(set! *main-cli-fn* -main)

