;; 画出下面表达式的求值过程的环境图示
(define x (cons 1 2))
(define z (cons x x))
(set-car! (cdr z) 17)

(car x)
17
;; 其中使用上面的序对过程实现
