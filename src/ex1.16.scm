(define (fast-expt b n)
  (fast-expt-iter b n 1))
(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
	((even? n) (fast-expt-iter (square b)
				   (/ n 2)
				   a))
	(else (fast-expt-iter b
			      (- n 1)
			      (* a b)))))
(define (square x)
  (* x x))
(fast-expt 10 4)
(fast-expt 10.0 4)

	