(load-r "c01/p24-fib.scm")
;; 数据抽象
;; 使用约定的界面
;; 高级过程的程序简单,但在复合数据做类似操作有依赖性
;; 例子
(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
	((not (pair? tree))
	 (if (odd? tree) (square tree) 0))
	(else (+ (sum-odd-squares (car tree))
		 (sum-odd-squares (cdr tree))))))

(define (even-fibs n)
  (define (next k)
    (if (> k n)
	()
	(let ((f (fib k)))
	  (if (even? f)
	      (cons f (next (+ k 1)))
	      (next (+ k 1))))))
  (next 0))
;; 共同模式 对序列的操作
;; 1. 枚举
(define (enumerate-interval low high)
  (if (> low high)
      ()
      (cons low (enumerate-interval (+ low 1) high))))
(enumerate-interval 2 7)
(define (enumerate-tree tree)
  (cond ((null? tree) ())
	((not (pair? tree)) (list tree))
	(else (append (enumerate-tree (car tree))
		      (enumerate-tree (cdr tree))))))
(enumerate-tree (list 1 (list 2 (list 3 4)) 5))
;; 2. 过滤
(define (filter predicate sequence)
  (cond ((null? sequence) ())
	((predicate (car sequence))
	 (cons (car sequence)
	       (filter predicate (cdr sequence))))
	(else (filter predicate (cdr sequence)))))
(filter odd? (list 1 2 3 4 5))
;; 3. 映射
(map square (list 1 2 3 4 5))
;; 4. 累积
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (accumulate op initial (cdr sequence)))))
(accumulate + 0 (list 1 2 3 4 5))

(define (sum-odd-squares tree)
  (accumulate +
	      0
	      (map square
		   (filter odd?
			   (enumerate-tree tree)))))
(sum-odd-squares (list 1 (list 2 (list 3 4)) 5))

(define (even-fibs n)
  (accumulate cons
	      ()
	      (filter even?
		      (map fib
			   (enumerate-interval 0 n)))))
(even-fibs 10)
;; convention interface, 帮助得到模块化的设计, 控制复杂度威力强大的策略
;; 只需要专注于信号的操作,而这些信号的操作是独立而完整的模块, 连接这些操作的也是完整的片段
(define (list-fib-sequares n)
  (accumulate cons
	      ()
	      (map square
		   (map fib
			(enumerate-interval 0 n)))))
(list-fib-sequares 10)
(define (product-of-squares-of-odd-elements sequence)
  (accumulate *
	      1
	      (map square
		   (filter odd? sequence))))
(product-of-squares-of-odd-elements (list 1 2 3 4 5))

;; 找出最大值,也是累积
;; (define (salary-of-highest-paid-programmer records)
;;   (accumulate max
;; 	      0
;; 	      (map salary
;; 		   (filter programmer? records))))
(define (max-of-list sequence)
  (accumulate max
	      0
	      sequence))
(max-of-list (list 1 2 3 4 5))
