;; 求根号3
(define (cube-root x)
  (cube-root-iter 1.0 x))

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x))
     0.001))

(define (improve y x)
  (/ (+ (/ x
           (square y))
        (* 2 y))
     3))

(define (cube x)
  (* x x x))

(define (square x)
  (* x x))

(cube-root 8.0)
;; 2.000004911675504
