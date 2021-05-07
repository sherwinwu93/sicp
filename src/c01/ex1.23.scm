(load (absolute "square")

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


;; 优化前
(load (absolute "c01/ex1.22.scm"))
;; 160 1.28
(test-foo 1000)
;; 266 1.47
(test-foo 10000)
;; 600 1.5
(test-foo 100000)
;; 1675 1.675
(test-foo 1000000)
;; 5028 1.612
(test-foo 10000000)
;; 15232 1.612
(test-foo 100000000)
;; 47442
(test-foo 1000000000)

;; 125
(test-foo 1000)
;; 183
(test-foo 10000)
;; 400
(test-foo 100000)
;; 1000
(test-foo 1000000)
;; 3100
(test-foo 10000000)
;; 9447
(test-foo 100000000)
;; 29867 1.612
(test-foo 1000000000)
;; 优化后,比值之所以不是2,因为next比+多了个判断的过程
(define (next x)
  (if (= x 2)
      3
      (+ x 2)))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
