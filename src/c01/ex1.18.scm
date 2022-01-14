(define (fast-multi a b)
  (cond ((= b 0) 0)
	((even? b) (fast-multi (double a)
			       (halve b)))
	(else
	 (+ a
	    (fast-multi a
			(- b 1))))))
