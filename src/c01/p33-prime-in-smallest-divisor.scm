(load "square")

(define (prime? n)
  (= (smallest-divisor n) 0))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (1+ test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))
