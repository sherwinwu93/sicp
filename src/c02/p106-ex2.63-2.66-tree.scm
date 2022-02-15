(load-r "c02/p104-order-set.scm")
;; ------------------------------------------------------------ 集合作为排序的表
;; 集合作为二叉树, 排序表的进一步优化
;; 左小,右大
;; 优点: 搜索时,x小于curr,只需搜索左子树.x大于curr,只需搜索右子树.
;;       如果树是平衡的,那么问题规模会由n规约为n/2,time=O(logn)

;; 树的表示
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
	((= x (entry set)) true)
	((< x (entry set)) (element-of-set? x (left-branch set)))
	((> x (entry set)) (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x () ()))
	((= x (entry set)) set)
	((< x (entry set))
	 (make-tree (entry set)
		    (adjoin-set x (left-branch set))
		    (right-branch set)))
	((> x (entry set))
	 (make-tree (entry set)
		    (left-branch set)
		    (adjoin-set x (right-branch set))))))
;; 我们无法保证这样adjoin-set的树一定是平衡的,有可能与一直往右边生长,对比排序表没有任何优势
;; 解决方案: 1. 定义一个操作(将任意树变换为平衡树),每次adjoin-set后都执行保证平衡
;;          2. 定义新的数据结构,设法使的搜索和插入都O(logn).红黑树
(define tree1 (adjoin-set 11 (adjoin-set 9 (adjoin-set 5 (adjoin-set 7 (adjoin-set 1 (adjoin-set 3 ())))))))
(define tree2 (adjoin-set 10 (adjoin-set 8 (adjoin-set 5 (adjoin-set 7 (adjoin-set 1 (adjoin-set 3 ())))))))

;; ------------------------------ 2.63
(define (tree->list-1 tree)
  (if (null? tree)
      ()
      (append (tree->list-1 (left-branch tree))
	      (cons (entry tree)
		    (tree->list-1 (right-branch tree))))))
(tree->list-1 tree1)
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
	result-list
	(copy-to-list (left-branch tree)
		      (cons (entry tree)
			    (copy-to-list (right-branch tree)
					  result-list)))))
  (copy-to-list tree ()))
(tree->list-2 tree1)
;; a.结果相同,都产生有序表
;; b.tree->list-2 增长得要慢一点, 因为append操作大致是O(N^2), 而cons操作则是O(N)
;; ------------------------------ 2.64

;; 将有序表变换为平衡二叉树
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

;; 构造包含这个表的前n个元素的平衡树
;; return: car部分平衡树, cdr剩余部分
(define (partial-tree elts n)
  (if (= n 0)
      (cons () elts)
      ;; 左树大小:n-1/2
      (let ((left-size (quotient (- n 1) 2)))
	;; 左边结果 paritial-tree elts left-size
	(let ((left-result (partial-tree elts left-size)))
	  (let ((left-tree (car left-result))
		;; 去除左树后的表
		(non-left-elts (cdr left-result))
		;; 右树大小 n - (left-size + 1)
		(right-size (- n (+ left-size 1))))
	    ;; 当前结点
	    (let ((this-entry (car non-left-elts))
		  ;; 右边结果
		  (right-result (partial-tree (cdr non-left-elts)
					      right-size)))
	      ;; 右树
	      (let ((right-tree (car right-result))
		    ;; 去除左树后,又去除右树的剩余表
		    (remaining-elts (cdr right-result)))
		;; 最终结果= make-tree this-entry left-tree right-tree
		(cons (make-tree this-entry left-tree right-tree)
		      remaining-elts))))))))
;; a.简要清楚地解释为什么partial-tree能完成工作.
;;   wishful thinking : 我们能得到left-result,non-left-elements.
;;                      我们能获得this-entry (car non-left-elements)
;;   wishful thinking:  我们能得到right-result,non-right-elements
;;                      构造起来 make-tree this-entry, left-tree(由left-result获取), right-tree(同理)
;;                      最简单情况n=0时,tree是()
;;
;; b.list->tree转换n个元素的表以什么量级增长O(n),因为每个元素都需要遍历,且只遍历一次
;; ------------------------------ 2.65
;; 实现union-set和intersection-set的O(n)实现
(define (union-tree tree1 tree2)
  (let ((list1 (tree->list-2 tree1))
	(list2 (tree->list-2 tree2)))
    (let ((list3 (union-set list1 list2)))
      (list->tree list3))))
(define (intersection-tree tree1 tree2)
  (let ((list1 (tree->list-2 tree1))
	(list2 (tree->list-2 tree2)))
    (let ((list3 (intersection-set list1 list2)))
      (list->tree list3))))
(union-tree tree1 tree2)
(intersection-tree tree1 tree2)

;; ------------------------------------------------------------ 信息与集合检索
;; 表表示集合的各种选择: 无序,有序,树, 性能各自不同
;; 查找: 未排序的表的实现,比较简单.但是最终还是一般用二叉树
(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
	((equals? given-key (key (car set-of-records)))
	 (car set-of-records))
	(else (lookup given-key (cdr set-of-records)))))
;; ------------------------------ 2.66
;; 二叉树表示法的lookup
(define (lookup given-key tree-of-records)
  (cond ((null? tree-of-records) false)
	((= given-key (key (entry tree-of-records)))
	 (car set-of-records))
	((> given-key (key (entry tree-of-records)))
	 (lookup given-key (right-branch tree-of-records)))
	((< given-key (key (entry tree-of-records)))
	 (lookup given-key (left-branch tree-of-records)))))
