(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (cube guess)
	     x))
     0.0001))

(define (improve guess x)
  (/ (+ (/ x
	   (square guess))
	(* 2.0 guess))
     3.0))

(define (cube x)
  (* x x x))

(define (cube-root x)
  (cube-root-iter 1.0 x))

(cube-root 8)

