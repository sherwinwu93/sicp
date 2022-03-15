(define (make-node left right item)
  (list 'left 'right item))
(define (left-node node)
  (car node))
(define (right-node node)
  (cadr node))
(define (item node)
  (caddr node))


(load-r "lib/assoc.scm")
(define (assoc key node)
  (if (null? node)
      false
      (let ((item-1 (item node)))
	(cond ((= key item-1) node)
	      ((> key item-1) (assoc key (left-node node)))
	      (else (assoc key (right-node node)))))))

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
	(cdr record)
	false)))
(define (make-table)
  (list '*table*))

(define t1 (make-table))
(insert! 'a 1 t1)
(insert! 'b 2 t1)
(insert! 'a 3 t1)
(lookup 'a t1)
