;; 类似乘法运算,差应该怎样计算
(load "p63-interval-procudure.scm")
(load "ex2.07.scm")
(define (sub-interval x y)
  (add-interval x
                (make-interval
                 (- (upper-bound y))
                 (- (lower-bound y)))))

(define x (make-interval 2 5))
(define y (make-interval 0 1))
(sub-interval x y)
