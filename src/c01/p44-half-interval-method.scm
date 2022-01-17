(load-r "lib/math.scm")
(define (half-interval-method f a b)
  (let ((a-value (f a))
	(b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
	   (search f a b))
	  ((and (negative? b-value) (positive? a-value))
	   (search f b a))
	  (else
	   (error "xxx" a b)))))

(define (search f neg-point pos-point)
  (let ((mid-point (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
	mid-point
	(let ((test-value (f mid-point)))
	  (cond ((negative? test-value)
		 (search f mid-point pos-point))
		((positive? test-value)
		 (search f neg-point mid-point))
		(else mid-point))))))

(define (close-enough? x y)
  (< (abs (- x y)) 0.001))

(half-interval-method sin 2.0 4.0)
(half-interval-method (lambda(x) (- (cube x) (* 2 x) 3))
		      1.0
		      2.0)
	  
		
