;; 修改make-account,带密码
(define acc (make-account 100 'secret-password))
;; 60
((acc 'secret-password 'withdraw) 40)
;; Incorrect password
((acc 'some-other-password 'withdraw) 50)

;; 方案四:除了存钱还有取钱
(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
	(begin (set! balance (- balance amount))
	       balance)
	"Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch input-password m)
    (if (eq? input-password password)

	(cond ((eq? m 'withdraw) withdraw)
	      ((eq? m 'deposit) deposit)
	      (else (error "Unknown request -- MAKE-ACCOUNT" m)))
	(error "Incorrect password")))
  dispatch)
(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 50)
((acc 'password 'deposit) 30)
