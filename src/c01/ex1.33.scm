(load "./smallest-divisor.scm")

(define (filtered-accumulate filter combiner null-value term a next b)
  (define (new-iterm x)
    (if (filter x)
        (term x)
        null-value))
  (accumulate combiner null-value new-iterm a next b))

;; a:区间a到b的所有素数之和
(define (f a b)
  (filtered-accumulate prime? + 0 (lambda(x) x) a 1+ b))
(f 1 10)

;; b:小于n的所有与n互素的正整数的乘积
(define (f n)
  (define (filter x)
    (= 1 (gcd x n)))
  (filtered-accumulate filter * 1 (lambda(x) x) 0 1+ n))

(f 10)
