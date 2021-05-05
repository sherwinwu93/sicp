;; 写过程fringe,以树(表的特殊形式)为参数,返回一个表,表是树的所有树叶,按照从左到右的顺序
(define x (list (list 1 2) (list 3 4)))

(fringe x)
->(1 2 3 4)

(fringe (list x x))
(1 2 3 4 1 2 3 4)
(define (fringe x)
  (cond ((null? x) ())
        ((not (pair? x)) (list x))
        (else
         (append
          (fringe (car x))
          (fringe (cdr x))))))
