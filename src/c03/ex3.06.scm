;; 重置随机数生成器
;; 实现过程rand: (rand 'generate) 产生新随机数, ((rand 'reset) <new-value>) 将内部状态变量设置为新的值
(define random-init 4)
(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))
(define (rand-update x)
  (random (+ 10000 x)))

(define (rand m)
  (define x 0)
  (define (rand-update x)
    (random (+ 10000 x)))
  (define (reset new-value)
    (begin (set! x new-value)
           x))
  (define (generate)
    (begin (set! x (rand-update x))
           x))
  (cond ((eq? m 'reset) reset)
        ((eq? m 'generate) (generate))
        (else
         (error "error"))))
(rand 'generate)
((rand 'reset) 100)
