(load-r "lib/math.scm")
(define (sqrt x)
  (define (try guess)
    (if (good-enough? guess)
	guess
	(try (improve guess))))

  (define (good-enough? guess)
    (< (abs (- (square guess)
	       x))
       0.0000000001))

  (define (improve guess)
    (average guess
	     (/ x guess)))

  (exact->inexact (try 1)))
(sqrt 9)
(sqrt 8)
  
