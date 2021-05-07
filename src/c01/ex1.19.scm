(load (absolute "c01/p26-fib.scm"))

;; T变换  a<-a+b 和 b<-a, 每次一步
;; Tpq新的变换 a<-bq+aq+ap 和 b<-bp+aq, 也是每次一步.变换Tpq两次,等同于变换一次Tp'q'.那么Tp'q',就相对于指数运算对于底数的square,对于乘法运算(用加法计算)对于乘数的double,time=O(logn)
;; step*2 变化
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
	((even? count)
	 (fib-iter a
		   b
		   (+ (square p) (square q))   ;; p'的表达式
		   (+ (* 2 p q) (square q))   ;; q'的表达式
		   (/ count 2)))
	(else (fib-iter (+ (* b q) (* a q) (* a p))
			(+ (* b p) (* a q))
			p
			q
			(- count 1)))))

(fib 10)
(fib 0)
(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
	
	      
