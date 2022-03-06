;; 修改make-account,带密码
(define acc (make-account 100 'secret-password))
;; 60
((acc 'secret-password 'withdraw) 40)
;; Incorrect password
((acc 'some-other-password 'withdraw) 50)


(define (make-account balance password)
  (let ((error-times 0))
    (define (withdraw amount)
      (if (>= balance amount)
	  (begin (set! balance (- balance amount))
		 balance)
	  "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (call-the-cops)
      (error "call police"))
    (define (dispatch input-password m)
      (if (eq? input-password password)
	  (begin (set! error-times 0)
		 (cond ((eq? m 'withdraw) withdraw)
		       ((eq? m 'deposit) deposit)
		       (else (error "Unknown request -- MAKE-ACCOUNT" m))))
	  (begin (set! error-times (+ error-times 1))
		 (if (>= error-times 7)
		     (call-the-cops)
		     (error "Incorrect password")))))
    dispatch))
