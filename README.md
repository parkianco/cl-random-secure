# cl-random-secure

Cryptographically secure random number generation for Common Lisp.
Uses /dev/urandom on Unix or CryptGenRandom on Windows. Zero external dependencies.

## Installation

```lisp
(asdf:load-system :cl-random-secure)
```

## API

- `(random-bytes n)` - Generate n random bytes
- `(random-integer bits)` - Generate random integer with specified bit length
- `(random-in-range min max)` - Generate random integer in [min, max)
- `(with-secure-random &body body)` - Execute body with secure random stream

## Example

```lisp
(cl-random-secure:random-bytes 32) ; => #(... 32 random bytes ...)
(cl-random-secure:random-integer 256) ; => 256-bit random integer
(cl-random-secure:random-in-range 1 100) ; => random integer in [1, 100)
```

## License

BSD-3-Clause - Parkian Company LLC 2024-2026
