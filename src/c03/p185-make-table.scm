(load-r "lib/assoc.scm")
(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
	(cdr record)
	false)))
(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
	(set-cdr! record value)
	(set-cdr! table
		  (cons (cons key value)
			(cdr table))))))
(define (make-table)
  (list '*table*))

(define t1 (make-table))
(insert! 'a 1 t1)
(insert! 'b 2 t1)
(insert! 'a 3 t1)
(lookup 'a t1)
