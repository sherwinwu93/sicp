(define (element-of-set? x set)
  (cond ((null? set) false)
	((= x (car set)) true)
	((< x (car set)) false)
	(else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      ()
      (let ((x1 (car set1)) (x2 (car set2)))
	(cond ((= x1 x2)
	       (cons x1
		     (intersection-set (cdr set1)
				       (cdr set2))))
	      ((< x1 x2)
	       (intersection-set (cdr set1)
				 set2))
	      ((> x1 x2)
	       (intersection-set set1
				 (cdr set2)))))))
;; ------------------------------ 2.61
(define (adjoin-set x set)
  (define (adjoin-set x set1 set2)
    (if (null? set1)
	(append set2 (list x))
	(let ((item (car set1)))
	  (cond ((< item x) (adjoin-set x (cdr set1) (append set2 (list item))))
		((= item x) (cons set1 set2))
		(else (append set2
			      (cons x set1)))))))
  (adjoin-set x set ()))
(adjoin-set 3 (list 1 2 4 5))
;; ------------------------------ 2.62
(define (union-set set1 set2)
  (cond ((null? set1) set2)
	((null? set2) set1)
	(else (let ((x1 (car set1))
		    (x2 (car set2)))
		(cond ((= x1 x2) (cons x1
				       (union-set (cdr set1)
						  (cdr set2))))
		      ((< x1 x2) (cons x1
				       (union-set (cdr set1)
						  set2)))
		      (else (cons x2
				  (union-set  set1
					      (cdr set2)))))))))
(union-set (list 1 3 4) (list 2 3 4 5))
