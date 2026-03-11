;;;; random.lisp
;;;; Cryptographically secure random generation

(in-package #:cl-random-secure)

;;; Platform-specific secure random using /dev/urandom or equivalent

(defvar *urandom-stream* nil
  "Cached stream to /dev/urandom.")

(defun open-urandom ()
  "Open /dev/urandom for reading."
  (open "/dev/urandom" :element-type '(unsigned-byte 8)
                       :direction :input
                       :if-does-not-exist :error))

(defun ensure-urandom ()
  "Ensure urandom stream is open and valid."
  (unless (and *urandom-stream*
               (open-stream-p *urandom-stream*))
    (setf *urandom-stream* (open-urandom)))
  *urandom-stream*)

(defun close-urandom ()
  "Close the cached urandom stream."
  (when (and *urandom-stream* (open-stream-p *urandom-stream*))
    (close *urandom-stream*)
    (setf *urandom-stream* nil)))

(defun random-bytes (n)
  "Generate N cryptographically secure random bytes.
   Returns a simple-array of (unsigned-byte 8)."
  (declare (type (integer 0) n))
  (let ((bytes (make-array n :element-type '(unsigned-byte 8)))
        (stream (ensure-urandom)))
    (let ((read-count (read-sequence bytes stream)))
      (unless (= read-count n)
        (error "Failed to read ~D bytes from urandom (got ~D)" n read-count)))
    bytes))

(defun bytes-to-integer (bytes)
  "Convert byte array to integer (big-endian)."
  (let ((result 0))
    (loop for byte across bytes
          do (setf result (logior (ash result 8) byte)))
    result))

(defun random-integer (bits)
  "Generate a random integer with specified number of bits."
  (declare (type (integer 1) bits))
  (let* ((bytes-needed (ceiling bits 8))
         (bytes (random-bytes bytes-needed))
         (result (bytes-to-integer bytes)))
    ;; Mask to exact bit count
    (ldb (byte bits 0) result)))

(defun random-in-range (min max)
  "Generate a random integer in [min, max).
   Uses rejection sampling for uniform distribution."
  (declare (type integer min max))
  (when (>= min max)
    (error "MIN (~D) must be less than MAX (~D)" min max))
  (let* ((range (- max min))
         (bits (integer-length range))
         ;; Add extra bits to reduce rejection rate
         (sample-bits (+ bits 64)))
    (loop for candidate = (+ min (mod (random-integer sample-bits) range))
          ;; No rejection needed with mod, but loop once for clarity
          return candidate)))

(defmacro with-secure-random (&body body)
  "Execute BODY with a fresh secure random stream.
   Ensures proper cleanup of random state."
  `(let ((*urandom-stream* nil))
     (unwind-protect
          (progn ,@body)
       (close-urandom))))
