(define (cc amount coin-values)
  (cond ((= amount 0) 1)
	((or (< amount 0) (no-more? coin-values)) 0)
	(else
	 (+ (cc amount
		(except-first-denomination coin-values)) ;;钱的种类减少
	    (cc (- amount
		   (first-denomination coin-values));;要兑换的钱总数减少
		coin-values)))))

;; 定义出first-denomination`except-first-denomination和no-more?
(define (first-denomination coin-values)
  (car coin-values))
(define (except-first-denomination coin-values)
  (cdr coin-values))
(define (no-more? coin-values)
  (null? coin-values))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 5 2 1 0.5))

(cc 100 us-coins)
;; 顺序不同不会影响结果,因为最后能换的零钱具体明细是一样的
