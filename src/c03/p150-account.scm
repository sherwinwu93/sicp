;; 变量balance表示账户的余额
(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))

;; 开始账户有100
;; 支取25=>75
(withdraw 25)
;; =>50
(withdraw 25)
;; =>"Insufficient funds"
(withdraw 60)
;; =>35
(withdraw 15)


;; 将balance改为账户的变量
;; 提款对象
(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))
;; 创建两个对象
(define W1 (make-withdraw 100))
(define W2 (make-withdraw 100))

;; =>50
(W1 50)
;; =>30
(W2 70)
;; =>Insufficient funds
(W2 40)
;; =>10
(W1 40)
;; 银行账户对象
(define (make-account balance)
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
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

(define acc (make-account 100))
;; =>50
((acc 'withdraw) 50)
;; =>"Insufficient funds"
((acc 'withdraw) 60)
;; =>90
((acc 'deposit) 40)
;; =>30
((acc 'withdraw) 60)

(define acc2 (make-account 100))


