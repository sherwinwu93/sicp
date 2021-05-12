(load-r "c02/p103-set-op.scm")
;; 未排序的set的交集
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else
         (cons (car set1) (union-set (cdr set1) set2)))))

(union-set (list 1 3 4) (list 2 4 5))
