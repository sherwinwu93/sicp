(load-r "c02/p112-huffman.scm")
;; generate-huffman-tree:
;;   传参:符号-频度对偶表
;;   返回:huffman树
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))
;; 写出successive-merge过程: 使用make-code-tree反复归并集合中具有最小权重的元素,直到集合只剩下一个元素为止.尽可能利用有序集合
;; 树叶数据抽象:make-leaf symbol weight,leaf? object,symbol-leaf x,weight-leaf x
;; 树数据抽象:make-code-tree left right,left-branch tree,right-branch tree,symbols tree,weight tree
(define (successive-merge leaf-set)
  (define (recur leaf-tree-set)
    (if (null? (cdr leaf-tree-set))
        (car leaf-tree-set)
        (recur (adjoin-set (make-code-tree (car leaf-tree-set) (cadr leaf-tree-set))
                           (cdr (cdr leaf-tree-set))))))
  (recur leaf-set))

(make-leaf-set (list (list 'a 4) (list 'b 2) (list 'c 1) (list 'd 1)))

(generate-huffman-tree (list (list 'a 4) (list 'b 2) (list 'c 1) (list 'd 1)))
