(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
(1 (4 (9 16) 25) (36 49))

;; 使用map
(define (square-tree tree)
  (map (lambda(sub-tree)
         (cond ((not (pair? sub-tree)) (square sub-tree))
               (else (square-tree sub-tree))))
       tree))

;; 对square-tree继续抽象
(define (square-tree tree)
  (tree-map square tree))

;; 使用map
(define (tree-map procedure tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map procedure sub-tree)
             (procedure sub-tree)))
       tree))
;; 不使用map
(define (tree-map procedure tree)
  (cond ((null? tree) ())
        ((not (pair? tree)) (procedure tree))
        (else
         (cons
          (tree-map procedure (car tree))
          (tree-map procedure (cdr tree))))))
