;; 二叉活动体:left right左右分支
(define (make-mobile left right)
  (list left right))

;; length是一个数, structure可能是数,或者另一个活动体
(define (make-branch length structure)
  (list length structure))
(define b1 (make-branch 1 2))
(define b2 (make-branch 3 (make-branch 4 5)))
(define m (make-mobile b1 b2))

;; a. 选择器left-branch和right-branch,返回活动体左右分支
;;    branch-length和branch-structure返回分支的成分
(left-branch m)
(define (left-branch mobile)
  (car mobile))

(right-branch m)
(define (right-branch mobile)
  (car (cdr mobile)))

(branch-length b2)
(define (branch-length branch)
  (car branch))

(branch-structure b2)
(define (branch-structure branch)
  (car (cdr branch)))
;; b.用选择器定义过程total-weight,返回活动体的总重量
(define (branch-is-structure branch)
  (pair? branch))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(branch-weight b2)
(define (branch-weight branch)
  (cond ((null? branch) 0)
        ((not (branch-is-structure branch)) branch)
        (else (+ (branch-length branch)
                 (branch-weight (branch-structure branch))))))
;; c.写出过程mobile-is-balance:返回活动体是否平衡
(define (mobile-is-balance mobile)
  (= (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))
(mobile-is-balance (make-mobile b1 (make-branch 1 2)))
(mobile-is-balance (make-mobile b1 b2))

;; d.改变活动体的表示,需要对程序做多少修改
;; 只需要改变选择器和构造器,已经改变了构造器,那末只需要改构造器
;; 由于mobile-is-structure内部使用数据结构不变,所以不需要改变
(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))
;; 需修改
;; 不需修改
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cdr mobile))
;; 不需修改
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cdr branch))

;; 由于构建了抽象屏障,分开了数据的表示和使用,所以只需要很小的改动
