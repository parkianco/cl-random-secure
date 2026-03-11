;;;; cl-random-secure.asd
;;;; Cryptographic random generation - zero external dependencies

(asdf:defsystem #:cl-random-secure
  :description "Cryptographically secure random number generation"
  :author "Parkian Company LLC"
  :license "BSD-3-Clause"
  :version "1.0.0"
  :serial t
  :components ((:file "package")
               (:module "src"
                :components ((:file "random")))))
