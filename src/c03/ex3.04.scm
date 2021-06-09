;; 修改ex3.03的make-account,加上局部状态变量,被不正确密码连续访问7次,就会调用过程call-the-cops
(define (make-account balance password)
  ;; 提款
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define error-times 0)
  (define (error-times+)
    (begin (set! error-times (+ 1 error-times))
           error-times))
  (define (reset-error-times)
    (begin (set! error-times 0)
           error-times))
  (define (call-the-cops)
    (display "call-the-cops"))
  ;; 存款
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch input-password m)
    (if (eq? input-password password)
        (begin (reset-error-times)
               (cond ((eq? m 'withdraw) withdraw)
                     ((eq? m 'deposit) deposit)
                     (else (error "Unknown request -- MAKE-ACCOUNT"
                                  m))))
        (begin (error-times+)
               (if (= error-times 7)
                   (call-the-cops)
                   (display "Incorrect password")))))
  dispatch)

(define acc (make-account 100 'secret-password))
;; 密码正确
((acc 'secret-password 'withdraw) 40)
60
;; 密码不正确
((acc 'some-other-password 'deposit) 50)
"Incorrect password"
