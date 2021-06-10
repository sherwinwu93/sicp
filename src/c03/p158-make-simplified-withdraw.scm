(load-r "c03/p150-account.scm")
(define (make-simplified-withdraw balance)
  (lambda (amount)
    (set! balance (- balance amount))
    balance))

(define W (make-simplified-withdraw 25))

(W 20)
5
(W 10)
-5
;; 没有使用set!
(define (make-decrementer balance)
  (lambda (amount)
    (- balance amount)))
(define D (make-decrementer 25))
(D 20)
5
(D 10)
15
;; D1和D2同一?
;; 不是
(define W1 (make-simplified-withdraw 25))

(define W2 (make-simplified-withdraw 25))
(W1 20)
5
(W1 20)
-15
(W2 20)
5
;; Peter 和 Paul
(define peter-acc (make-account 100))
(define paul-acc (make-account 100))

;; Peter 和 Paul同一个账号
(define peter-acc (make-account 100))
(define paul-acc peter-acc)
