(define (transfers-type args)
  (define (find-any list)
    (if (null? list)
	false
	(let ((item (car list)))
	  (if item
	      item
	      (find-any (cdr list))))))
  (define (transfers-type-iter type-z)
    (let ((cannot-transfers
	   (filter (lambda(arg)
		     (not (get-coercion (type-tag arg) type-z)))
		   args)))

      (if (null? cannot-transfers)
	  (map (lambda(arg)
		 (let ((type-x (type-tag arg)))
		   (if (eq? type-x type-z)
		       arg
		       ((get-coercion type-x type-z) arg))))
	       args)
	  false)))

  (let ((type-tags (map type-tag args)))
    (find-any (map transfers-type-iter type-tags))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))

    (let ((proc (get op type-tags)))

      (if proc
	  (apply proc (map contents args))
	  (let ((new-args (transfers-type args)))

	    (if new-args
		(apply apply-generic op new-args)
		(error "No method for these types"
		       (list op type-tags))))))))
