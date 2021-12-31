(load-r "c03/ex3.12.scm")
;; 考虑make-cycle过程,使用3.12的last-pair过程
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
;; 画出盒子指针,说明下面
(define z (make-cycle (list 'a 'b 'c)))
;; z
;; 计算(last-pair z)
;; 死循环
