(load "init")
(load-r "c03/ex3.13.scm")
;; Ben写一过程,统计任何表结构的序对个数
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))
;; 说明其不正确,画出盒子指针,由3个序对构成,分别返回3,4,7,根本不返回
(count-pairs (list 'a 'b 'c))
(define x (cons 'b 'c))
(count-pairs (cons 'a (cons x x)))
(define x (cons 'a 'b))
(define y (cons x x))
(define z (cons y y))
(count-pairs z)

(define z
  (make-cycle (list 'a 'b)))
(count-pairs z)
