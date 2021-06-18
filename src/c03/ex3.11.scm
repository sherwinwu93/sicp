;; 典型的消息传递过程包括两个方面:
;;   1. 局部状态
;;   2. 局部定义
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
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)
(define acc (make-account 50))
((acc 'deposit) 40)
90
((acc 'withdraw) 60)
30
;; acc的局部状态保存在哪里?
(define acc2 (make-account 100))
;; 两个账户的局部状态如何保持不同?环境结构中哪些部分被acc和acc2共享
