;; 蒙特卡罗积分
;;   eg.计算圆的面积 S圆=P*S矩形
;; 写出过程estimate-integral, 传参P,矩形的边界x1,x2,y1,y2, 要求实验次数
(load-r "c03/p155-monte-carlo.scm")
(define (estimate-integral P x1 x2 y1 y2 trials)
  (let ((x (exact->inexact(- x2 x1)))
	(y (exact->inexact (- y2 y1))))
    (define (experiment)
      (let ((rand-x (random x))
	    (rand-y (random y)))
	(p rand-x rand-y)))
    (* x y (monte-carlo trials experiment))))
(define (p x y)
  (let ((a1 (square (- x 5)))
	(a2 (square (- y 7))))
    (<= (+ a1 a2)
       (square 3))))
(estimate-integral p 2 8 4 10 10000)
