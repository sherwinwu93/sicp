;; 定义square-tree过程:square所有叶子
;; 两种方式一种不使用map,一种使用map
(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
(1 (4 (9 16) 25) (36 49))

;; 不使用map
(define (square-tree tree)
  (cond ((null? tree) ())
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))
;; 使用map
(define (square-tree tree)
  (map (lambda(sub-tree)
         (cond ((not (pair? sub-tree)) (square sub-tree))
               (else (square-tree sub-tree))))
       tree))
