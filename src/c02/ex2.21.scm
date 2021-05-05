;; 写出过程square-list:返回每个数平方的表
(square-list (list 1 2 3 4))
-> (1 4 9 16)
(square 3)
;; 1.
(define (square-list items)
  (if (null? items)
      ()
      (cons (square (car items)) (square-list (cdr items)))))
;; 2.
(define (square-list items)
  (map square items))
