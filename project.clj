(defproject refh "0.1.0"
  :description "Command-line tool for pasting to refheap."
  :url "https://github.com/Raynes/refh"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.4.0"]]
  :plugins [[lein-cljsbuild "0.2.5"]]
  :cljsbuild {:builds [{:source-path "src"
                        :compiler {:output-to "refh.js"
                                   :target :nodejs
                                   :optimizations :advanced}}]})
