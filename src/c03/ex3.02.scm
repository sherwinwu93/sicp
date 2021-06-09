;; 过程make-monitored,传参:过程f,f本身有输入.
;;                    返回:过程mf,用内部计数器维持着自己被调用的次数
;;                                输入特殊符号how-many-calls?,就返回内部计数器的值;
;;                                reset-count,mf重新设置为0
;;                                任何其他输入,mf返回过程f,并将内部计数器加1
(define s (make-monitored sqrt))
(s 100)
10
(s 'how-many-calls)
1
(s 100)
10
(s 'how-many-calls)
2
(s 'reset-count)
0
(define (make-monitored f)
  (define N 0)
  (define (how-many-calls)
    N)
  (define (reset-count)
    (begin (set! N 0)
           N))
  (define (mf x)
    (begin (set! N (+ N 1))
           (f x)))
  (define (dispatch x)
    (cond ((eq? x 'how-many-calls) (how-many-calls))
          ((eq? x 'reset-count) (reset-count))
          (else (mf x))))
  dispatch)
