(define (good-enough? guess x)
  (< (/ (improve guess x)
	x)
     0.01))

