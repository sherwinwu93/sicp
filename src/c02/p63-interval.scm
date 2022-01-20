;; ex2.07
(define (make-interval a b)
  (cons a b))

(define upper-bound cdr)

(define lower-bound car)

;; 假设(make-interval l u) (lower-bound x) (upper-bound x)

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
		 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
	(p2 (* (lower-bound x) (upper-bound y)))
	(p3 (* (upper-bound x) (lower-bound y)))
	(p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
		   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
		(make-interval (/ 1.0 (upper-bound y))
			       (/ 1.0 (lower-bound y)))))

;; ex2.08
;; 乘法推导除法一样
(define (sub-interval x y)
  (add-interval x
		(make-interval (- (upper-bound y))
			       (- (lower-bound y)))))
;; ex2.09
;; x`y的区间都
;; ex2.10
(define inverse-obj
  (lambda(i) (cons (/ 1 (lower-bound i)) (/ 1 (upper-bound i)))))
(define (div-interval x y)
  (if (<= (* (lower-bound y) (upper-bound y)) 0)
      (error "y should not include zero")
      (mul-interval x
		    (inverse-obj y))))
(define x (make-interval 1 2))
(define y (make-interval 0 2))

(div-interval x y)
;; ex2.11 mul-interval分为9种情况

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
;; ex2.12
;; 定义make-center-percent
(define (make-center-percent c p)
  (let ((w (/ (* c p) 100)))
    (make-center-width c w)))
(define (percent i)
  (let ((w (width i)))
    (* 100 (/ w (center i)))))
;; 误差很小的情况下
;; PyWy/Cy + PxWx/Cx是乘积的百分比误差值

;;ex2.13
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
		(add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
		  (add-interval (div-interval one r1)
				(div-interval one r2)))))
(define r1 (make-interval 2.4 3.6))
(define r2 (make-interval 3.2 4.8))
(par1 r1 r2)
;Value 13: (.9142857142857141 . 3.085714285714286)
(par2 r1 r2)
;Value 14: (1.3714285714285712 . 2.057142857142857)
;; ex2.14 Lem确实是对的
(div-interval r1 r1)
;; A/A, 即便是A/A也存在区间扩大的情况
(define r3 (make-center-percent 3 0.1))
(define r4 (make-center-percent 4 0.1))
(div-interval r3 r3)
(div-interval r3 r4)
;; 区间宽度与百分比成正比
;; ex2.15 par2比par1更好的程序
;; 我认为说的不对,因为R=U/I. U/(U/R1+U/R2) = 1/(1/R1+1/R2). 更接近实际情况.
;; 实际情况是,U/R1, 区间已经变化了.
;; 旧的div实现中,已经做了一次区间运算了
;; ex2.16
;; 只做一次区间运算,即div时使用inverse-obj,而不是区间转换
;; 感谢社区答案给的启发, 不应该盲目迷信课本,而应该靠自己检查
