;; p46-fixed-point.scm
(load-r "lib/math.scm")
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (print-two x y)
    (display x)
    (display " ")
    (display y)
    (newline)
    )
  (define (try guess)
    (let ((next (f guess)))
      (print-two guess next)
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(define (f y)
  (fixed-point (lambda(x) (/ (log y)
			     (log x)))
	       2.0))
(f 1000)
;; 40次

(load-r "lib/average-damp.scm")
(define (f-damp y)
  (fixed-point (average-damp (lambda (x) (/ (log y)
					    (log x))))
	       2.0))

(f-damp 1000)
;; 10次
