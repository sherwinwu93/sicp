(load-r "c02/p103-set-op.scm")
;; 定义set的union-set过程
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else
          )))
