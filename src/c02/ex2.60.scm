;; 允许重复,重新定义set
;;   {1, 2, 3}, 可以表示为表(2 3 2 1 3 2 2)
;; 定义element-of-set?`adjoin-set`union-set`intersection-set
(define (element-of-set? x set1)
  (cond ((null? set1) false)
        ((= (car set1) x) true)
        (else (element-of-set? x (cdr set1)))))
(element-of-set? 4 (list 1 2 3 5))

(define (adjoin-set x set1)
  (cons x set1))
(adjoin-set 2 (list 2 3 4 ))

(define (union-set set1 set2)
  (if (null? set1)
      set2
      (cons (car set1) (union-set (cdr set1) set2))))
(union-set (list 1 2 3) (list 3 4 6))

(define (intersection-set set1 set2)
  (cond ((null? set1) ())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else
         (intersection-set (cdr set1) set2))))
(intersection-set (list 2 3 4 4) (list 3 5 4))

;; 什么情况下使用重复的???
;; 增加或删除操作多,而查询少. java中也要视情况选择工具
