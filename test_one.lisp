;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

(load "cl-random-secure.asd")
(handler-case
  (progn
    (asdf:test-system :cl-random-secure/test)
    (format t "PASS~%"))
  (error (e)
    (format t "FAIL~%")))
(quit)
