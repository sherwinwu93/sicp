(load-r "c01/ex1.37.scm")
(load-r "lib/math.scm")
(define (tan-cf x k)
  (cont-frac
   (lambda (i) (if (= i 1)
		   x
		   (- 0 (square x))))
   (lambda (i) (- (* 2 i) 1))
   k))
(tan-cf 1 1000)
