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
(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (assoc key records)
      (cond ((null? records) false)
	    ((same-key? key (caar records)) (car records))
	    (else (assoc key (cdr records)))))
    (define (lookup key)
      (let ((record (assoc key (cdr local-table))))
	(if record
	    (cdr record)
	    false)))
    (define (insert! key value)
      (let ((record (assoc key (cdr local-table))))
	(if record
	    (set-cdr! record value)
	    (set-cdr! local-table
		      (cons (cons key value)
			    (cdr local-table))))))
    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
	    ((eq? m 'insert!) insert!)
	    (else (error "unknown operation table" m))))
    dispatch))
(define (same-key? x y)
  (< (abs (- x y)) 0.001))
(define t1 (make-table same-key?))
((t1 'insert!) 10 100000)
((t1 'lookup) 10.0009)
