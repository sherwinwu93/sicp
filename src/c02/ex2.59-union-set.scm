(load-r "c02/p103-collection.scm")

(define (union-set set1 set2)
  (cond ((null? set1) set2)
	((element-of-set? (car set1) set2)
	 (union-set (cdr set1) set2))
	(else
	 (cons (car set1)
	       (union-set (cdr set1) set2)))))
(union-set (list 1 2 3 4) (list 3 4 5 6))
