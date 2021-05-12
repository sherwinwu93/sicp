(load-r "c02/p103-set-op.scm")
;; 定义set的union-set过程
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else
         (cons (car set1) (union-set (cdr set1) set2)))))
;; union-set的O(n)实现
;; 用归并的方法
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1))
               (x2 (car set2)))
           (cond ((< x1 x2) (cons x1 (union-set (cdr set1) set2)))
                 ((> x1 x2) (cons x2 (union-set (cdr set2) set1)))
                 ((= x1 x2) (cons x1 (union-set (cdr set1) (cdr set2)))))))))
(union-set (list 2 4 5) (list 1 2 3 4 6))
