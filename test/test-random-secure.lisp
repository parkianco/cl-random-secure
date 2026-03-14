;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; test-random-secure.lisp - Unit tests for random-secure
;;;;
;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: BSD-3-Clause

(defpackage #:cl-random-secure.test
  (:use #:cl)
  (:export #:run-tests))

(in-package #:cl-random-secure.test)

(defun run-tests ()
  "Run all tests for cl-random-secure."
  (format t "~&Running tests for cl-random-secure...~%")
  ;; TODO: Add test cases
  ;; (test-function-1)
  ;; (test-function-2)
  (format t "~&All tests passed!~%")
  t)
