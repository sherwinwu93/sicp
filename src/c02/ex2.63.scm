(load-r "c02/p106-tree.scm")
(define set1 (make-tree 7
                        (make-tree 3
                                   (make-tree 1 () ())
                                   (make-tree 5 () ()))
                        (make-tree 9
                                   ()
                                   (make-tree 11 () ()))))
(define set2 (make-tree 3
                        (make-tree 1
                                   ()
                                   ())
                        (make-tree 7
                                   (make-tree 5
                                              ()
                                              ())
                                   (make-tree 9
                                              ()
                                              (make-tree 11
                                                         ()
                                                         ())))))
(define set3 (make-tree 5
                        (make-tree 3
                                   (make-tree 1
                                              ()
                                              ())
                                   ())
                        (make-tree 9
                                   (make-tree 7
                                              ()
                                              ())
                                   (make-tree 11
                                              ()
                                              ()))))
(define set4 (make-tree 5
                        (make-tree 3
                                   (make-tree 1
                                              ()
                                              ())
                                   ())
                        (make-tree 9
                                   (make-tree 7
                                              ()
                                              ())
                                   ())))
;; 树转换成表
;; time=O(n)
(define (tree->list-1 tree)
  (if (null? tree)
      ()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree ()))
;; a. 两过程对所有树都产生同样结果?如果不是,结果有什么不同?对图2-16树产生什么样的表?
;; 结果都是相同的,按顺序排列
;; 1
(tree->list-1 set1)
(tree->list-1 set2)
(tree->list-1 set3)
;; 2
(tree->list-2 set1)
(tree->list-2 set2)
(tree->list-2 set3)
;; b. 将n个结点的平衡树变换为表,两个过程所需的time相同吗?
;; time相同:O(n),空间1:O(logn),空间2:O(n)
