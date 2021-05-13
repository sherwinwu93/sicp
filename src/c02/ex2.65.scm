(load-r "c02/ex2.62.scm")
(load-r "c02/ex2.63.scm")
(load-r "c02/ex2.64.scm")
;; 可用的过程tree->list1,tree->list2,list->tree,union-set,intersection-set
;; 过程union-tree的O(n)实现
(define (union-tree tree another)
  (list->tree
   (union-set (tree->list-1 tree)
              (tree->list-1 another))))
(union-tree set1 set4)
;; 过程intersection-tree的O(n)实现
(define (intersection-tree tree another)
  (list->tree
   (intersection-set (tree->list-1 tree)
                     (tree->list-1 another))))
(intersection-tree set1 set4)

