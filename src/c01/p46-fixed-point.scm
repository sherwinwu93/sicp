;; p46-fixed-point.scm
(load-r "lib/math.scm")
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(fixed-point cos 1.0)

(define (sqrt x)
  (fixed-point (lambda(y) (average y (/ x y)))
	       1.0))
(sqrt 4)
