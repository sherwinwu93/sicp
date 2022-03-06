;; 方案一: 带来的问题,可以不通过银行修改金额
(define balance 100)
(define (withdraw amount)
  (if (> balance amount)
      (begin (set! balance (- balance amount))
	     balance)
      "Insufficient funds"))
;; 假设银行账户有100
;; 75
(withdraw 25)
;; 50
(withdraw 25)
;; Insufficient funds
(withdraw 60)
;; 35
(withdraw 15)
;; 方案二:使用局部变量,只有通过银行才能修改金额
(define withdraw
  (let ((balance 100))
    (lambda(amount)
      (if (> balance amount)
	  (begin (set! balance (- balance amount))
		 balance)
	  "Insufficient funds"))))
;; 方案三:
(define (make-withdraw balance)
  (lambda(amount)
      (if (> balance amount)
	  (begin (set! balance (- balance amount))
		 balance)
	  "Insufficient funds")))
(define W1 (make-withdraw 100))
(define W2 (make-withdraw 100))
;; 50
(W1 50)
;; 30
(W2 70)
;; 方案四:除了存钱还有取钱
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
	(begin (set! balance (- balance amount))
	       balance)
	"Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
	  ((eq? m 'deposit) deposit)
	  (else (error "Unknown request -- MAKE-ACCOUNT" m))))
  dispatch)
(define acc (make-account 100))
((acc 'withdraw) 50)
((acc 'deposit) 30)
