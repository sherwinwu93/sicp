(define x (list 1 2 3))
(define y (list 4 5 6))
(append x y)
->(1 2 3 4 5 6)
(cons x y)
;; 先求内部模型,再求打印结果
->((1 2 3) 4 5 6)
(list x y)
->((1 2 3) (4 5 6))
