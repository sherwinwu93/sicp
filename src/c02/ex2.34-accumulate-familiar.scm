
(load-r "c02/p76-convention-interface.scm")
;; 对于给定值x,求出多项式的值
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ (* higher-terms x)
						   this-coeff))
	      0
	      coefficient-sequence))

(horner-eval 2 (list 1 3 0 5 0 1))
