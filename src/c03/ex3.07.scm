;; make-account创建带有密码的银行账户对象
;; make-joint: 创建共用账户
;;   传参: 有密码保护的账户;密码;新密码
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
(define peter-acc (make-account 100 'open-sesaem))

(define paul-acc
  (make-joint peter-acc 'open-sesaem 'rosebud))

(define (make-joint acc password joint-password)
  (define (delegate input-joint-password m)
    (if (eq? input-joint-password joint-password)
        (acc password m)
        (display "Incorrect joint-password")))
  delegate)
