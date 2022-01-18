(load-r "lib/math.scm")
(define (average-damp f)
  (lambda(y)
    (average y
	     (f y))))
