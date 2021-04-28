;; 将平均阻尼运用到sqrt
(define (average x y)
  (/ (+ x y) 2))
(define (average-damp f)
  (lambda(x) (average x (f x))))
;; 55
((average-damp square) 10)
;; 应用到平方根
(load "p46-fixed-point.scm")
;; 把三种思想结合: 不动点搜寻,平均阻尼和函数y->x/y
;; 将有用的元素表现为相互分离的个体,还可以重新用作其他应用
;; 从sqrt抽象出平均阻尼法
(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))
(sqrt 4)
;; 用于其他地方 提取立方根
(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))
(cube-root 8)
