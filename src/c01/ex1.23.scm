(load "square")

(define (prime? n)
  (= (smallest-divisor n) n))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(load "ex1.22.scm")
;; 未改前 240
(timed-prime-test (search-for-primes 100000000000))

;; 改了后 160
(define (next x)
  (if (= x 2)
      3
      (+ x 2)))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(timed-prime-test (search-for-primes 100000000000))

;; 比值是3/2
