;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; cl-random-secure.asd
;;;; Cryptographic random generation - zero external dependencies

(asdf:defsystem #:cl-random-secure
  :description "Cryptographically secure random number generation"
  :author "Parkian Company LLC"
  :license "BSD-3-Clause"
  :version "0.1.0"
  :serial t
  :components ((:file "package")
               (:module "src"
                :components ((:file "random")))))

(asdf:defsystem #:cl-random-secure/test
  :description "Tests for cl-random-secure"
  :depends-on (#:cl-random-secure)
  :serial t
  :components ((:module "test"
                :components ((:file "test-random-secure"))))
  :perform (asdf:test-op (o c)
             (let ((result (uiop:symbol-call :cl-random-secure.test :run-tests)))
               (unless result
                 (error "Tests failed")))))
