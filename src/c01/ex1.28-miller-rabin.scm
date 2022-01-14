;; ex1.28-miller-rabin.scm
;; p34-fermat-test
(load-r "lib/math.scm")

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((nontrivial-sqrt base m) 0)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))
;; true有非凡
;; false没有
(define (nontrivial-sqrt a n)
  (and (not (= a 1))
       (not (= a (- n 1)))
       (= (remainder
	   (square a)
	   n) 
	  1)))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n)
  (define (iter n times)
    (cond ((= times 0) true)
	   ((miller-rabin-test n) (iter n (- times 1)))
	   (else false)))
  (iter n (ceiling (/ n 2))))


(miller-rabin-test 561)
(miller-rabin-test 562)
(miller-rabin-test 1105)
(miller-rabin-test 1729)
(miller-rabin-test 2465)
(miller-rabin-test 2821)
(miller-rabin-test 6601)
(miller-rabin-test 767)
(miller-rabin-test 17)
