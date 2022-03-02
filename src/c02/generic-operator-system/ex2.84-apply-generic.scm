(define (raise-to-same-type arg1 arg2)
  (define (temp a1 a2)
    (if (and a1 a2 (eq? (type-tag a1) (type-tag a2)))
	(list a1 a2)
	(temp (raise a1) a2)))
  (let ((type1-args (temp arg1 arg2)))
    (if type1-args
	type1-args
	(temp arg2 arg1))))
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (if (= (length args) 2)
	      (let ((same-type-args (raise-to-same-type (car args) (cadr args))))
		(if same-type-args
		    (apply apply-generic op same-type-args)
		    (error "No method for these types" (list op type-tags)))
		(error "No method for these types" (list op type-tags))))))))
