(define (carmichael-test n)
  (test-iter n 2))

(define (test-iter n a)
  (cond ((= a n) #t)
        ((= a (expmod a n n))
         (test-iter n (+ a 1)))
        (else #f)))

(load "p34-prime-in-fermat-test.scm")

;; #t
(carmichael-test 561)
;; #t
(carmichael-test 1105)
;; #t
(carmichael-test 1729)
;; #t
(carmichael-test 2465)
;; #t
(carmichael-test 2821)
;; #t
(carmichael-test 6601)
