(load-r "c02/p103-collection.scm")
(define (element-of-list? x list)
  (cond ((null? list) false)
	((equals? x (car list)) true)
	(else (element-of-list? x (cdr list)))))

(define (ajoin-list x list)
  (cons x list))

(define (union-list list1 list2)
  (define (union-list list1 list2 list3)
    (cond ((and (null? list1) (null? list2)) list3)
	  ((null? list1)
	   (if (element-of-list? (car list2) list3)
	       (union-list list1 (cdr list2) list3)
	       (union-list list1 (cdr list2) (cons (car list2) list3))))
	  (else
	   (if (element-of-list? (car list1) list3)
	       (union-list (car list1) list2 list3)
	       (union-list (cdr list1) list2 (cons (car list1) list3))))))
  (union-list list1 list2 ()))

(define (intersection-list list1 list2)
  (define (intersection-list list1 list2 list3)
    (cond ((or (null? list1) (null? list2)) list3)
	  ((element-of-list? (car list1) list2)
	   (intersection-list (cdr list1) list2 (cons (car list1) list3)))
	  (else
	   (intersection-list (cdr list1) list2 list3))))
  (intersection-list list1 list2 ()))

(union-list (list 1 3 4) (list 3 4 5))

(intersection-list (list 1 3 4) (list 3 4 5))
