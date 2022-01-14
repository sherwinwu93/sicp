;; 快速乘法实现
(load-r "lib/math.scm")
(define (fast-multi a b)
  (fast-multi-iter a b 0))
(define (fast-multi-iter a b p)
  (cond ((= b 0) p)
	((even? b)
	 (fast-multi-iter (double a)
			  (halve b)
			  p))
	(else
	 (fast-multi-iter a
			  (- b 1)
			  (+ p a)))))
(fast-multi 3 4)
