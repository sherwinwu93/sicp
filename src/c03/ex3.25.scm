(load-r "lib/assoc.scm")
;; lookup key-1 key-2
;; insert! key-1 key-2 value
(define (last-key? keys)
  (null? (cdr keys)))
(define (lookup keys table)
  (if (last-key? keys)
      (let ((record (assoc (car keys) (cdr table))))
	(if record
	    (cdr record)
	    false))
      (let ((subtable (assoc (car keys) (cdr table))))
	(if subtable
	    (lookup (cdr keys) subtable)
	    false))))
(define (insert! keys value table)
  (if (last-key? keys)
      (let ((record (assoc (car keys) (cdr table))))
	(if record
	    (set-cdr! record value)
	    (set-cdr! table
		      (cons (cons (car keys)
				  value)
			    (cdr table)))))
      (let ((subtable (assoc (car keys) (cdr table))))
	(if subtable
	    (insert! (cdr keys) value subtable)
	    (let ((new-subtable (list (car keys))))
	      (set-cdr! table
			(cons new-subtable
			      (cdr table)))
	      (insert! (cdr keys) value new-subtable))))))
(define (make-table)
  (list '*table*))

(define t1 (make-table))
(insert! (list 'a 'b) 1 t1)
(insert! (list 'c 'd) 2 t1)
(insert! (list 'e 'f 'g) 3 t1)
(lookup (list 'e 'f 'g) t1)
(lookup (list 'c 'b) t1)
