;; 修改make-account过程,创建带密码保护的账户
;; 银行账户对象
(define (make-account balance password)
  ;; 提款
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  ;; 存款
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch input-password m)
    (if (eq? input-password password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT"
                           m)))
        (display "Incorrect password")))
  dispatch)

(define acc (make-account 100 'secret-password))
;; 密码正确
((acc 'secret-password 'withdraw) 40)
60
;; 密码不正确
((acc 'some-other-password 'deposit) 50)
"Incorrect password"
