;; 蒙特卡罗积分:固定定积分值的方法
;; P(x, y):区域的面积计算问题,在区域内部的点(x,y)为真,不在区域内为假
;; 圆: 圆心(5,7) 半径:3.
;; 实现过程estimate-integral,以谓词P,矩形的上下边界x1`x2`y1和y2,以及要求试验的次数.该过程应该使用monte-carlo过程.
;; 用estimate-integral,计算PI

(load "init")
(load-r "c03/p155-rand.scm")
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))


(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (average x y) (/ (abs (- x y))
                           2))
  (display P)
  (* (monte-carlo trials (lambda ()
                           (P (random-in-range x1 x2)
                              (random-in-range y1 y2)
                              (average x1 x2))))
     (* (- x2 x1) (- y2 y1))))

(define (P x y r)
  (<= (+ (* x x)
         (* y y))
      (* r r)))
(estimate-integral P -1 1 -1 1 1000000)

(P (random-in-range -1 1)
   (random-in-range -1 1)
   1)
