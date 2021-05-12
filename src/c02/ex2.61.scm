(load-r "c02/p103-set-op.scm")
;; 排序表示adjoin-set
(define (adjoin-set x set1)
  (define (iter left x right)
    (if (or (null? right) (< x (car right)))
        (append left (list x) right)
        (iter (append left (list (car right)))
              x
              (cdr right))))
  (if (element-of-set? x set1)
      set1
      (iter () x set1)))
;; element-of-set?利用已排序的优势,一半的步树
(define (element-of-set? x set1)
  (define (iter skipped set2)
    (cond ((null? set2) (equal? skipped x))
          ((= x (car set2)) true)
          ((< x (car set2)) (equal? skipped x))
          ((null? (cdr set2)) false)
          ((null? (cdr (cdr set2))) (equal? (cadr set2) x))
          (else (iter (cadr set2) (cdr (cdr set2))))))
  (iter -1 set1))
(adjoin-set 4 (list 2 3 4 5))
