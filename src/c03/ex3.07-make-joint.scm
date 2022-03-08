;; 共用帐号
;; 定义过程make-joint, 有密码保护的账户,密码,新密码

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

(define (make-joint origin-acc origin-password new-password)
  (lambda(input-password m)
    (if (eq? new-password input-password)
	(origin-acc origin-password m)
	(error "Incorrect password"))))

(define peter-acc (make-account 100 'open-sesame))

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosehud))
((paul-acc 'rosehud 'deposit) 88)
((peter-acc 'open-sesame 'deposit) 99)
