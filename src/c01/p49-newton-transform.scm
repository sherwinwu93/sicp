(load "p46-fixed-point.scm")
;; 牛顿法公式
;; 导数公式
(define (deriv g)
  (lambda(x)
    (/ (- (g (+ x dx)) (g x))
       dx)))
(define dx 0.00001)

(define (cube x) (* x x x))
;; 12
((deriv cube) 2)
;; 牛顿法, 由定义y^2=x,y是x的平方根, 变为y^2-x=0,牛顿法直接求出y的值:y^2-x=0,根据牛顿法公式,变成了求fixed-point的问题(由零点问题变成不动点问题),再由fixed-point求出y的值.
(define (newton-transform g)
  (lambda(x)
    (- x (/ (g x) ((deriv g) x)))))
(define (newton-method g guess)
  (fixed-point (newton-transform g) guess))
;; 从sqrt抽象出newton法
(define (sqrt x)
  (newton-method (lambda(y) (- (square y) x))
                 1.0))
(sqrt 4)
