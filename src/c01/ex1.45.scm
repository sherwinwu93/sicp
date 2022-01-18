(load-r "lib/math.scm")
(load-r "lib/fixed-point.scm")
(load-r "lib/average-damp.scm")
;; 平均阻尼
;; 实现一个过程,使用fixed-point`average-damp`repeated过程计算n次方根
(define (sqrt x)
  (fixed-point
   (average-damp (lambda(y) (/ x y)))
   1.0))
(sqrt 4)

(define (cube-root x)
  (fixed-point
   ((repeated average-damp 2)
    (lambda(y) (/ x (square y))))
   1.0))
(cube-root 27)

(define (n-root x n)
  (fixed-point
   ((repeated average-damp (- n 1))
    (lambda(y) (/ x (expt y (- n 1)))))
   1.0))

(n-root 16 4)
