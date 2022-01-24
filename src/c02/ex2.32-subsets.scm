(define (subsets s)
  (if (null? s)
      (list ())
      (let ((rest (subsets (cdr s))))
	(append rest (map
		      (lambda(sub-set)
			(cons (car s) sub-set))
		      rest)))))
(subsets (list 1 2 3))
;; 因为subsets等于有第一个元素的subsets再加上没有第一个元素的subsets
