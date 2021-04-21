;; 迭代方式的求幂计算过程,时间复杂度要求O(logm)
(define (fast-expt b n)
  (fast-expt-iter 1 b n))

;; 定义不变量,要求在状态之间保持不变,是思考迭代算法设计问题的一种非常强有力的方法
;; 即product
;; 关键在于底数变化 底数有b->b^2->(b^2)^2...
(define (fast-expt-iter product b n)
  (cond ((= n 0) product)
	((even? n) (fast-expt-iter product (square b) (/ n 2)))
	(else (fast-expt-iter (* product b)
			      b
			      (- n 1)))))


(define (even? n)
  ( = (remainder n 2) 0))
(even? 0)

(fast-expt 2 10)
	 
  
      
