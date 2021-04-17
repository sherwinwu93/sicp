;;ex2.17 列表最后一个元素
(define (last-pair arr)
  (if (null? (cdr arr))
      (car arr)
      (last-pair (cdr arr))))
;;ex2.17 test
(last-pair (list 23 7 159 34))

;;ex2.18 逆转列表
(define (reverse arr)
  (if (null? arr)
      list
      (cons (reverse (cdr arr)) (car arr))))
;;ex2.18 test
(reverse (list 23 7 159 34))

;;换零钱玩法
(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
	((or (< amount 0) (= kinds-of-coins 0)) 0)
	(else (+ (cc amount
		     (- kinds-of-coins 1))
		 (cc (- amount
			(first-denomation kinds-of-coins))
		     kinds-of-coins)))))

(define (first-denomation kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
	((= kinds-of-coins 2) 5)
	((= kinds-of-coins 3) 10)
	((= kinds-of-coins 4) 25)
	((= kinds-of-coins 5) 50)))

(count-change 100)

;;ex2.19 换零钱改进
(define (cc amount coin-values)
  (cond ((= amount 0) 1)
	((or (< amount 0) (no-more? coin-values)) 0)
	(else
	 (+ (cc amount
		(except-first-denomation coin-values))
	    (cc (- amount
		   (first-denomation coin-values))
		coin-values)))))

(define (first-denomation arr)
  (car arr))

(define (except-first-denomation arr)
  (cdr arr))

(define (no-more? arr)
  (null? arr))

;;ex2.19 test
(cc 100 (list 1 5 10 25 50))
;;列表元素顺序不会影响结果
(cc 100 (list 5 1 10 25 50))

;;ex2.20
(define (even? a)
  (remainder (car a) 2))
(even? 1 2 3 4 5)
(even? 2 3 4 5)
(= (even? 2 3 4 5) (even? 4 3 2 5))

(even? 1)
(even? 3)
(equal? #f #f)
(define (same-parity-iter first-even  a)
  (cond ((null? a) a)
	((equal? (even? (car a)) first-even)
	 (cons (car a)
	       (same-parity-iter first-even  (cdr a))))
	(else
	 (same-parity-iter first-even  (cdr a)))))
(cons 1 2)
(cons 2 3)
(cons 1 (cons 2 3))
;;递归过程里面不能使用可变传参
(define (same-parity . w)
  (display w)
  (same-parity-iter (even? w)  w))

(same-parity 1 2 3 4 5)

(same-parity  1 2 3 4 5)
(define (f x y . z)
  z)
(f 1 2 3 4 5)

;;它人的解法
(define (same-parity sample . others)
  (filter (if (even? sample)
	      even?
	      odd?)
	  (cons sample others)))
;;过程也是数据,同样可以使用判断的方式改变
;;test
(same-parity 2 3 4 5 6)

				  

		   
