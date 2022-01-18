;; Ni = 1
;; DI = 1,2,1,1,4,1,1,6,1,1,8
(load-r "c01/ex1.37.scm")
(define (e-2 k)
  (cont-frac (lambda (i) 1.0)
	     (lambda (i) (if (= (remainder i 3) 2)
			     (* 2
				(/ (+ i 1)
				   3))
			     1))
	     k))
(e-2 100)
