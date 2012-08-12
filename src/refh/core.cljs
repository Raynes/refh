(ns refh.core
  (:require [cljs.nodejs :as node]
            [refh.refheap :as rh]))

(defn -main
  "I don't do a whole lot."
  [& args]
  (rh/request nil nil
              (fn [error response body]
                (prn body))))

(set! *main-cli-fn* -main)