;; pair可以只用过程表示,也可以用赋值和局部状态的过程表示
(define (cons x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
	  ((eq? m 'cdr) y)
	  ((eq? m 'set-car!) set-x!)
	  ((eq? m 'set-cdr!) set-y!)
	  (else (error "Undefined operation -- CONS" m))))
  dispatch)

(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z new-value) ((z 'set-car!) new-value) z)
(define (set-cdr! z new-value) ((z 'set-cdr!) new-value) z)

(define z (cons 1 2))
(car z)
(cdr z)
(set-car! z 3)
(set-cdr! z 4)
;; 环境模型:遵循时间先后顺序,先内部define,再创建环境. lambda不存储信息,只返回lambda或者环境变量
