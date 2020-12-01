(define (cube-root x)
  (cube-root-iter 1.0 x))

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))

(good-enough? 1.0 8.0)
(define (good-enough? guess x)
  (< (abs (- (cube guess) x))
     0.001))

(define (abs x)
  (if (> x 0)
      x
      (- 0 x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess))
     3))
(define (cube x)
  (* x x x))
(define (square x)
  (* x x))
(cube-root 8.0)

