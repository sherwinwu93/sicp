;; 求解工程问题系统
;; 例如: Rp=1/(1/R1 + 1/R2),电阻误差10%,R1,R2从6.12-7.48,那末Rp也有个误差值
;; 解决方案: 区间算术, 输入区间计算,+-*/仍然是一个区间
;; Georage's Contract: 区间对象:make-interval,lower-bound,upper-bound
;; 区间加法
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
;; 区间乘法
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
;; 区间除法,由mul-interval转化
(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))
