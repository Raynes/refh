(ns refh.refheap
  (:require [cljs.nodejs :as node]))

(def req (node/require "request"))

(defn request [endpoint params callback]
  (.get req "https://www.refheap.com/api/paste/1" callback))
