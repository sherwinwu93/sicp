;;区间加法
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
		 (+ (upper-bound x) (upper-bound y))))
;;区间乘法
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x ) (lower-bound y)))
	(p2 (* (lower-bound x ) (upper-bound y)))
	(p3 (* (upper-bound x ) (lower-bound y)))
	(p4 (* (upper-bound x ) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
		   (max p1 p2 p3 p4))))
;;区间除法
(define (div-interval x y)
  (mul-interval x
		(make-interval (/ 1.0 (upper-bound y))
			       (/ 1.0 (lower-bound y)))))
;;区间构造
(define (make-interval a b) (cons a b))
;;区间打印
(define (print-interval x)
  (display (lower-bound x))
  (display " ")
  (display (upper-bound x)))
(print-interval (make-interval 2 5))
;;ex2.7 上下区间
(define (upper-bound x)
  (let ((a (car x))
	(b (cdr x)))
    (if (> a b)
	a
	b)))
(define (lower-bound x)
  (let ((a (car x))
	(b (cdr x)))
    (if (> a b)
	b
	a)))
;;ex2.7 test
(lower-bound (make-interval 2 5))
(upper-bound (make-interval 2 5))
;;ex2.8 加法->减法
(define (subtract-interval x y)
  (add-interval x
		(make-interval (- 0.0 (upper-bound y))
			       (- 0.0 (lower-bound y)))))
;;ex2.8 test
(lower-bound (subtract-interval
	      (make-interval 2 2)
	      (make-interval -4 -5)))
(upper-bound (subtract-interval
	      (make-interval 2 2)
	      (make-interval -4 -5)))

;;ex2.9
;;ex2.10 区间除法优化
(define (div-interval x y)
  (cond ((or (= (upper-bound y) 0) (= (lower-bound y) 0))
	(display "y should not equals zero"))
	(else (mul-interval x
			    (make-interval (/ 1.0 (upper-bound y))
					   (/ 1.0 (lower-bound y)))))))
;;ex2.10 test
(div-interval (make-interval 2 3)
	      (make-interval 0 4))
;;ex2.11瞎优化不要理
;;ex2.12 区间的不同表示法
;;中心-区间宽度表示法
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
;;中心
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
;;区间宽度
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
;;中心-区间宽度test
(lower-bound (make-center-width 10 2))
(upper-bound (make-center-width 10 2))
;;ex2.12 中心-百分比(由中心-区间宽度推理而来)
(define (make-center-percent c p)
  (let ((w (* c p)))
    (make-center-width c w)))
;;ex2.12 测试
(lower-bound (make-center-percent 10 0.2))
;;ex2.13 电阻的两种算法
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
		(add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
		  (add-interval (div-interval one r1)
				(div-interval one r2)))))

;;lem说两式结果不一样
;;lem说法测试
;;数据r1 6.8+-0.68
;;数据r2 4.7+-5%
(print-interval (par1 (make-center-width 6.8 0.68)
		      (make-center-percent 4.7 0.05)))
(print-interval (par2 (make-center-width 6.8 0.68)
		      (make-center-percent 4.7 0.05)))
;;相差非常大

;;1.借助之前的方法,推理出新的方法,加法->减法,乘法->除法
;;2.新的方法要注意可能存在的异常,除数不能为0
;;3.运算过程中,上一层使用下一层的结果,下一层的结果力求准确,并联电阻的例子
;;4.可以有多种表示方法,适应不同的需求,方差的表示方法.
;;test git



