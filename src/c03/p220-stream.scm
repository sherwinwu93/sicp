;; ------------------------------------------------------------ 3.5 流
;; ------------------------------------------------------------ 3.5.1 流作为延时的表
;; (cons-stream x y)
;; (stream-car s)
;; (stream-cdr s)
;; the-empty-stream
;; stream-null?
;; ------------------------------ 已实现
;; (define (stream-ref s n)
;;   (if (= n 0)
;;       (stream-car s)
;;       (stream-ref (stream-cdr s) (- n 1))))
;; ------------------------------ 已实现
;; (define (stream-map proc s)
;;   (if (stream-null? s)
;;       the-empty-stream
;;       (cons-stream (proc (stream-car s))
;; 		   (stream-map proc (stream-cdr s)))))
;; ------------------------------ 已实现
;; (define (stream-for-each proc s)
;;   (if (stream-null? s)
;;       'done
;;       (begin (proc (stream-car s))
;; 	     (stream-for-each proc (stream-cdr s)))))
;; ------------------------------ 已实现
;; stream-for-each对考察流非常有用
;; 流和常规表数据抽象完全一样,不同点在于元素的求值时间
;; promise
;; (delay exp) => promise
;; (force promise) => exp
;; ------------------------------ 已实现
;; (define (cons-stream a b)
;;   (cons a (delay b)))
;; ------------------------------ 已实现
;; (define (stream-car stream)
;;   (car stream))
;; ------------------------------ 已实现
;; (define (stream-cdr stream)
;;   (force (cdr stream)))
;; ------------------------------ 已实现
;; (define the-empty-stream ())
;; ------------------------------ 已实现
;; (define (stream-null? stream) (null? stream))
;; ------------------------------ 已实现

;; ------------------------------ 已实现
;; ------------------------------ 已实现
;; (cons 10000 (delay (stream-enumerate-interval 10001 1000000)))
;; ------------------------------ 已实现
;; (define (stream-filter pred stream)
;;   (cond ((stream-null? stream) the-empty-stream)
;; 	((pred (stream-car stream))
;; 	 (cons-stream (stream-car stream)
;; 		      (stream-filter pred
;; 				     (stream-cdr stream))))
;; 	(else (stream-filter pred (stream-cdr stream)))))
;; ------------------------------ 已实现
;; ------------------------------------------------------------ delay和force的实现
;; ------------------------------ 已实现
;; (define (delay proc)
;;   (memo-proc (lambda() proc)))
;; ------------------------------ 已实现
;; (define (force delayed-object)
;;   (delayed-object))
;; ------------------------------ 已实现
;; ------------------------------ ex3.50 stream-map的推广
;; ------------------------------ 已实现
;; (define (stream-map proc . argstreams)
;;   (if (stream-null? (car argstreams))
;;       the-empty-stream
;;       (cons-stream
;;        (apply proc (map (lambda(s) (stream-car s)) argstreams))
;;        (apply stream-map
;; 	      (cons proc (map (lambda(s) (stream-cdr s)) argstreams))))))
;; (stream-ref (stream-map + (stream-enumerate-interval 1 10) (stream-enumerate-interval 11 20)) 1)
;; ------------------------------ 已实现
;; ------------------------------ ex3.51
(load-r "lib/stream-operations.scm")

;; 按执行顺序 0 1 2 3 4 5 6 7 8 9 10
(define x (stream-map show (stream-enumerate-interval 0 10)))

;; 从第0个开始算,5
(stream-ref x 5)
(stream-ref x 7)
;; ------------------------------ ex3.52
(define sum 0)
;; sum=0
(define (accum x)
  (set! sum (+ x sum))
  sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
;; sum=210
(define y (stream-filter even? seq))
(define z (stream-filter (lambda(x) (= (remainder x 5) 0))
			 seq))
(stream-ref y 7)
(display-stream z)
sum
;; 上面表达式求值后sum的值210,
;; stream-ref ,第8个偶数, display-stream z ,所有整除5的数的序列
;; 不使用memo-proc会有不同.因为原来accum执行20次, 不使用accum执行210次.这就是赋值带来的复杂性
;; ------------------------------------------------------------ 3.5.2 无穷流
(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))
;; 利用integers定义另外一些无穷流
;; 不能被7整除的整数的流
(define (divsible? x y) (= (remainder x y) 0))
(define no-sevens
  (stream-filter (lambda(x) (not (divsible? x 7)))
		 integers))
(stream-ref no-sevens 100)
(define (fibgen a b)
  (cons-stream a (fibgen b (+ a b))))
;; fibs的car是0,cdr是(fibgen 1 1)的Promise. 求(fibgen 1 1)时,car是1,cdr是(fibgen 1 2)的Promise ...
(define fibs (fibgen 0 1))
;; 厄拉多塞筛法,构造出素数的无穷流
(define (sieve stream)
  (cons-stream
   (stream-car stream)
   (sieve (stream-filter
	   (lambda(x)
	     (not (divsible? x (stream-car stream))))
	   (stream-cdr stream)))))
(define primes (sieve (integers-starting-from 2)))
(stream-ref primes 50)
;; ------------------------------------------------------------ 隐式地定义流
;; integers 和 fibs都是靠定义递归过程定义的,这些递归过程计算出流的元素
;; 现在show you 直接用数据定义流
(define ones (cons-stream 1 ones))
(define (add-streams s1 s2)
  (stream-map + s1 s2))
(define integers (cons-stream 1 (add-streams ones integers)))
(define fibs
  (cons-stream 0
	       (cons-stream 1
			    (add-streams (stream-cdr fibs)
					 fibs))))
;; factor:因子
(define (scale-stream stream factor)
  (stream-map (lambda(x) (* x factor)) stream))
;; 2的幂无限流
(define double (cons-stream 1 (scale-stream double 2)))
(stream-show double 10)
;; 素数无限流
(define primes
  (cons-stream
   2
   (stream-filter prime? (integers-starting-from 3))))
(load-r "lib/math.scm")
(define (prime? n)
  (define (iter ps)
    (cond ((> (square (stream-car ps)) n) true)
	  ((divisible? n (stream-car ps)) false)
	  (else (iter (stream-cdr ps)))))
  (iter primes))
(stream-ref primes 8)
;; ------------------------------ ex3.53
;; 2的指数
(define s (cons-stream 1 (add-streams s s)))
(stream-show s 10)
;; ------------------------------ ex3.54
(define factorials (cons-stream 1
				(mul-streams (integers-starting-from 2) factorials)))
(stream-show factorials 2)
;; ------------------------------ ex3.55
(define (partial-sums s)
  (define sums
    (cons-stream
     (stream-car s)
     (add-streams (stream-cdr s) sums)))
  sums)
(define (partial-sums s)
  (cons-stream
   (stream-car s)
   (stream-map
    (lambda(x) (+ x (stream-car s)))
    (partial-sums (stream-cdr s)))))
(stream-show (partial-sums integers) 4)
;; ------------------------------ ex3.56
(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
	((stream-null? s2) s1)
	(else
	 (let ((s1car (stream-car s1))
	       (s2car (stream-car s2)))
	   (cond ((< s1car s2car)
		  (cons-stream s1car (merge (stream-cdr s1) s2)))
		 ((> s1car s2car)
		  (cons-stream s2car (merge s1 (stream-cdr s2))))
		 (else
		  (cons-stream s1car (merge (stream-cdr s1)
					    (stream-cdr s2)))))))))
(define S (cons-stream 1 (merge
			  (merge (scale-stream s 2)
				 (scale-stream s 3))
			  (scale-stream s 5))))
(stream-show s 10)
;; ------------------------------ ex3.57
(define fibs (cons-stream 0
			  (cons-stream 1
				       (add-streams fibs (stream-cdr fibs)))))
;; n-1次
;; 如果不使用memo-proc的优化,那么add-streams时形成了递归树,成指数倍增加
;; ------------------------------ ex3.58
;; 除法:顺序产生小数部位
(define (expand num den radix)
  (cons-stream
   ;; 求整数商
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))
(stream-show (expand 1 7 10) 20)
;; ------------------------------ ex3.59
;; 用流表示无穷多项式
;; a.
(define (integrate-series as)
  (stream-map / as integers))
;; b. e^x的积分就是e^x本身
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))
;; sin的导数是cos, cos的导数是负的sin
(define cosine-series
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
(stream-show exp-series 10)
