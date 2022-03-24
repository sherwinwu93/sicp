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
;; (stream-show double 10)
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
;; (stream-show s 10)
;; ------------------------------ ex3.54
(define factorials (cons-stream 1
				(mul-streams (integers-starting-from 2) factorials)))
;; (stream-show factorials 2)
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
;; (stream-show (partial-sums integers) 4)
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
;; (stream-show s 10)
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
;; (stream-show (expand 1 7 10) 20)
;; ------------------------------ ex3.59
;; 用流表示无穷多项式
;; a.
(define (integrate-series as)
  (stream-map / as integers))
;; b. e^x的积分就是e^x本身
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))
;; sin的导数是cos, cos的导数是负的sin
;; 最终和是cos(1)的值,因为这里默认系数是1
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
(define cosine-series
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))
;; 最终和为1
;; (stream-show cosine-series 10)
;; sin(1)的值
;; (stream-show sine-series 10)
;; (stream-show exp-series 10)
;; ------------------------------ ex3.60
(define (mul-series s1 s2)
  (cons-stream
   (* (stream-car s1)
      (stream-car s2))
   (add-streams (scale-stream (stream-cdr s1)
			      (stream-car s2))
		(mul-series s1
			    (stream-cdr s2)))))
(define sine-square+cosine-square
  (add-streams (mul-series sine-series sine-series)
	       (mul-series cosine-series cosine-series)))
;; (stream-show sine-square+cosine-square 10)
;; 把sine认为是流,把cosine认为是流.最后两流的平方和是1
;; ------------------------------ ex3.61
;; (stream-show (integrate-series ones) 10)
;; s的常数项为1, 非常数项为(stream-cdr s)
(define (reciprocal s)
  (cons-stream 1
	       (scale-stream
		(mul-streams (stream-cdr s) (reciprocal s))
		-1)))
;; (stream-show
;; (mul-series (reciprocal integers) integers)
;; 100)
;; ------------------------------ ex3.62定义div-series
(define (div-series s1 s2)
  (if (= 0 (stream-car s2))
      (erorr "no-zero s2")
      (mul-series s1 (reciprocal s2))))
(div-series sine-series cosine-series)
;; ------------------------------------------------------------ 3.5.3 流计算模式的使用
;; ------------------------------------------------------------ 系统地将迭代操作方式表示为流过程
(define (sqrt-improve guess x)
  (average guess (/ x guess)))
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
		 (stream-map (lambda(guess) (sqrt-improve guess x))
			     guesses)))
  guesses)
;; (stream-show (sqrt-stream 100) 10)
(define (pi-summands n)
  (cons-stream (/ 1.0 n)
	       (scale-stream (pi-summands (+ n 2))
			     -1)))
(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))
;; (stream-show pi-stream 10)
(load-r "lib/math.scm")
;; 序列加速器.逼近序列,而且要快的多
(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
	(s1 (stream-ref s 1))
	(s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
			  (+ s0 (* -2 s1) s2)))
		 (euler-transform (stream-cdr s)))))
;; (stream-show (euler-transform pi-stream) 10)
;; 加速是一个流s1, 加速加速流为流s1的流s11
(define (make-tableau transform s)
  (cons-stream s
	       (make-tableau transform
			     (transform s))))
(define (accelerated-sequence transform s)
  (stream-map stream-car
	      (make-tableau transform s)))
;; ------------------------------ ex3.63
;; 过于低效
(define (sqrt-stream x)
  (cons-stream 1.0
	       (stream-map (lambda(guess)
			     (sqrt-improve guess x))
			   (sqrt-stream x))))
;; 确实过于低效,因为sqrt-stream会重复计算, 如果delay没采用memo-proc会一样低效,会重复计算(tail (tail...))
;; ------------------------------ ex3.64
(define (stream-limit s tolerance)
  (let ((s0 (stream-ref s 0))
	(s1 (stream-ref s 1)))
    (if (< (abs (- s0 s1)) tolerance)
	s0
	(stream-limit (stream-cdr s) tolerance))))
(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
(sqrt 100 0.0001)
;; ------------------------------ ex3.65
(define (e-summands n)
  (cons-stream
   (/ 1.0 n)
   (scale-stream (e-summands (+ n 1))
		 -1)))
;; (stream-show (e-summands 1) 10)
;; ------------------------------------------------------------ 序对的无穷流

;; int-pairs满足i<=j
;; prime-sum-pairs
;; (stream-filter (lambda(pair)
;; 		 (prime? (+ (car pair) (cadr pair))))
;; 	       int-pairs)
;; (stream-map (lambda(x) (list (stream-car s) x))
;; 	    (stream-cdr t))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (stream-append
    (stream-map (lambda(x) (list (stream-car s) x))
		(stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))
;; ------------------------------ 已实现
;; 有穷流
;; (define (stream-append s1 s2)
;;   (if (stream-null? s1)
;;       s2
;;       (cons-stream (stream-car s1)
;; 		   (stream-append (stream-cdr s1) s2))))
;; ------------------------------ 已实现
;; 无穷流
(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
		   (interleave s2 (stream-cdr s1)))))
(define (pairs s t)
  (cons-stream
   (list (stream-car s)
	 (stream-car t))
   (interleave
    (stream-map (lambda(x) (list (stream-car s) x))
		(stream-cdr t))
    (pairs (stream-cdr s)
	   (stream-cdr t)))))
(pairs integers integers)
(stream-ref (pairs integers integers) 2)
;; 2^2^n
;; (stream-show (pairs integers integers) 50)
;; ------------------------------ ex3.67
(define (pairs s t)
  (cons-stream
   (list (stream-car s)
	 (stream-car t))
   (interleave
    (stream-map (lambda(x) (list (stream-car s) x))
		(stream-cdr t))
    (pairs (stream-cdr s)
	   t))))
;; ------------------------------ ex3.68
;; (define (pairs s t)
;;   (interleave
;;    (stream-map (lambda(x) (list (stream-car s) x))
;; 	       t)
;;    (pairs (stream-cdr s) (stream-cdr t))))
;; 不可行,无线递归
(pairs integers integers)
;; ------------------------------ ex3.69
(define (triples s t u)
  (let ((pairs-tu (pairs t u)))
    (define (triples s tu)
      (cons-stream
       (append (list (stream-car s)) (stream-car tu))
       (interleave
	(stream-map (lambda(x) (append (list (stream-car s)) x))
		    (stream-cdr tu))
	(triples (stream-cdr s)
		 (stream-cdr tu)))))
    (stream-filter
     (lambda(x) (= (+ (square (car x)) (square (cadr x))) (square (caddr x))))
     (triples s pairs-tu))))
;; ;; (stream-show (triples integers integers integers) 2)
(define (merge-weighted s t weight)
  (cond ((stream-null? s) t)
	((stream-null? t) s)
	(else
	 (if (<= (weight (stream-car s))
		 (weight (stream-car t)))
	     (cons-stream (stream-car s)
			  (merge-weighted (stream-cdr s) t weight))
	     (cons-stream (stream-car t)
			  (merge-weighted s (stream-cdr t) weight))))))
(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s)
	 (stream-car t))
   (merge-weighted
    (stream-map (lambda(x) (list (stream-car s) x))
		(stream-cdr t))
    (weighted-pairs (stream-cdr s)
		    (stream-cdr t)
		    weight)
    weight)))
(stream-show
 (weighted-pairs integers
		 integers
		 (lambda(x) (+ (car x) (cadr x))))
 20)
;; ------------------------------ ex3.71
;; (define (ramanujan weight)
;;     (define (stream-limit-ramanujan s)
;;       (let ((s0 (stream-ref s 0))
;; 	    (s1 (stream-ref s 1)))
;; 	(if (= (weight (car s0) (cadr s0))
;; 	       (weight (car s1) (cadr s1)))
;; 	    (cons-stream s0
;; 			 (stream-limit-ramanujan (stream-cdr (stream-cdr s))))
;; 	    (stream-limit-ramanujan (stream-cdr s)))))
;;     (stream-limit-ramanujan (weighted-pairs integers integers weight)))
;; (define (triple x) (* x x x))
;; (stream-show (ramanujan (lambda (i j) (+ (triple i) (triple j)))) 10)
(define (stream-cadr s) (stream-car (stream-cdr s)))
(define (stream-cddr s) (stream-cdr (stream-cdr s)))
(define (triple x) (* x x x))
(define (sum-triple x) (+ (triple (car x)) (triple (cadr x))))
(define (ramanujan s)
  (let ((scar (stream-car s))
	(scadr (stream-cadr s)))
    (if (= (sum-triple scar) (sum-triple scadr))
	(cons-stream (list (sum-triple scar) scar scadr)
		     (ramanujan (stream-cddr s)))
	(ramanujan (stream-cdr s)))))
(stream-show (ramanujan (weighted-pairs integers integers sum-triple)) 10)
