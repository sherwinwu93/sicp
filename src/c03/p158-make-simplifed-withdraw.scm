(define (make-simplified-withdraw balance)
  (lambda(amount)
    (set! balance (- balance amount))
    balance))
(define W (make-simplified-withdraw 25))
(W 20)
(W 10)

(define (make-decrementer balance)
  (lambda(amount)
    (- balance amount)))
(define D (make-decrementer 25))
(D 20)
(D 10)

((make-decrementer 25) 20)
((lambda(amount) (- 25 amount)) 20)
(- 25 20)
5

;; 代换没有环境的概念,认为所有值都是不变的

;; ------------------------------------------------------------
;; 同一和变化
;;    引用透明性
(define D1 (make-decrementer 25))
(define D2 (make-decrementer 25))
(d1 5)
(d2 5)
;; d1和d2是同一的,是,因为他们行为完全相同

(define W1 (make-simplified-withdraw 25))
(define W2 (make-simplified-withdraw 25))
(w1 10)
(w2 10)

(load-r "c03/p150-withdraw.scm")
(define peter-acc (make-account 100))
(define paul-acc (make-account 100))
;; 与下面有实质的不同
(define peter-acc (make-account 100))
(define paul-acc peter-acc)
