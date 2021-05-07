
(load (absolute "c01/ex1.17.scm"))
(load (absolute "c01/ex1.16.scm"))

;; 乘法的迭代运算 time=O(logn)
(define (fast-multi a b)
  (fast-multi-iter 0 a b))

(define (fast-multi-iter product a b)
  (cond ((= b 0) product)
	((even? b) (fast-multi-iter product (double a) (halve b)))
	(else (fast-multi-iter (+ product a)
			  a
			  (- b 1)))))

(fast-multi 4 10)

;; 由此可见,关键在于底数(例如:x的y次方,变为x^2的y/2次方;再比如:x乘以y,变为double x乘以havle y).x是小步,x的翻倍是一大步,由此路径不断折半.并且使用一个额外的值记录所有走下的路.




