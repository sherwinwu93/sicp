(load-r "c02/p67-list.scm")
;; reverse,排列顺序相反
(define (reverse list)
  (define (reverse-iter list1 list2)
    (if (null? list1)
	list2
	(reverse-iter (cdr list1) (cons (car list1) list2))))
  (reverse-iter list '()))

(define (reverse list)
  (if (null? list)
      '()
      (append (reverse (cdr list)) (cons (car list) ()))))

(reverse (list 1 4 9 16 25))
