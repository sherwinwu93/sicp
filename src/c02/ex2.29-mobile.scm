;; mobile branch length structure
;; mobile = left-branch + right-branch
;; branch = length + structure
;; structure = branch or weight


;; a. 写出left-branch和right-branch, branch-length和branch-structure
;; ----------------------------------------
(define (make-mobile left right)
  (list left right))
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile))
;; 另外一种函数
(define (make-mobile left right)
  (cons left right))
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cdr mobile))

(define (mobile-total-weight mobile)
  (+ (branch-total-weight (left-branch mobile))
     (branch-total-weight (left-branch mobile))))

(define (make-branch length structure)
  (list length structure))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch))
(define (make-branch length structure)
  (cons length structure))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cdr branch))
(define (branch-total-weight branch)
  (let ((structure (branch-structure branch)))
    (if (not (pair? structure))
	structure
	(mobile-total-weight structure))))
;; ----------------------------------------

;; b. 定义total-weight,活动体的总重量
;; c. 活动体是平衡的,左分支长度x总重量=右分支长度x总重量, 且所有子活动体也平衡
(define (mobile-balance? mobile)
  (let ((lb (left-branch mobile))
	(rb (right-branch mobile)))
    (let ((current-balance? (= (* (branch-length lb)
				  (branch-total-weight lb))
			       (* (branch-length rb)
				  (branch-total-weight rb))))
	  (ls (branch-structure lb))
	  (rs (branch-structure rb)))
      (cond ((and (not (pair? ls))
		  (not (pair? rs))) current-balance?)
	    ((and (pair? ls)
		  (not (pair? rs))) (and current-balance? (mobile-balance? ls)))
	    ((and (pair? rs)
		  (not (pair? ls))) (and current-balance? (mobile-balance? rs)))
	    (else
	     (and current-balance?
		  (mobile-balance? ls)
		  (mobile-balance? rs)))))))


(define l11 (make-branch 1 1))
(define l12 (make-branch 1 1))
(define m1 (make-mobile l11 l12))
(define l1 (make-branch 2 m1))
(define l2 (make-branch 2 2))
(define m0 (make-mobile l1 l2))
(mobile-total-weight m0)
(branch-total-weight l12)
(mobile-balance? m1)
(mobile-balance? m0)
;; d. 只需要修改构造器和选择器
