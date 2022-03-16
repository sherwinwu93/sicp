;; 记忆法,表格法
(define (fib n)
  (cond ((= n 0) 0)
	((= n 1) 1)
	(else (+ (fib (- n 1))
		 (fib (- n 2))))))

(define memo-fib
  (memoize (lambda(n)
	     (cond ((= n 0) 0)
		   ((= n 1) 1)
		   (else (+ (memo-fib (- n 1))
			    (memo-fib (- n 2))))))))
(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
	(or previously-computed-result
	    (let ((result (f x)))
	      (insert! x result table)
	      result))))))
;; 为(memo-fib 3)画出环境图.为什么memo-fib time=O(n), 定义为(memoize fib) 能否正常工作
;; 直接用fib不会正常工作,因为fib仍然是递归树
