;; p103-collection.scm
;; 有理数和代数表达式,构造时或简化时简化有关的表示 -> 集合的表示
;; 集合的数据抽象:
;;    union-set并集`intersection-set交集`element-of-set?是否是成员`adjoin-set添加元素
;; ------------------------------ 集合作为未排序的表
;; time=O(n)
(load-r "c02/ex2.54-equals.scm")
(define (element-of-set? x set)
  (cond ((null? set) false)
	;; eq?只可用于符号,我们需要判断非符号
	((equals? x (car set)) true)
	(else (element-of-set? x (cdr set)))))
;; time=O(n)
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))
;; 递归策略
;; time=O(n^2)
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
	((element-of-set? (car set1) set2)
	 (cons (car set1)
	       (intersection-set (cdr set1) set2)))
	(else (intersection-set (cdr set1) set2))))

(element-of-set? 1 (list 1 2 3))
(adjoin-set 4 (list 1 2 3))
(intersection-set (list 1 2 'a 'b) (list 2 'a 3 4))
