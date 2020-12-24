(define (* a b)
  (cond ((= b 0) 0)
	((even? b) (* (double a)
		      (halve b)))
	(else (+ a (* a
		      (- b 1))))))
(define (double x)
  (+ x x))
(double 2)

(define (halve x)
  (/ x 2))
(halve 4)
(define (even? x)
  (= (remainder x 2) 0))

(even? 5)
(* 10 3)
