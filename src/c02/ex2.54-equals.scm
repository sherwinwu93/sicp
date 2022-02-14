(define (equals? a b)
  (cond ((and (not (pair? a)) (not (pair? b)))
	 (eq? a b))
	((and (pair? a) (pair? b))
	 (and (equals? (car a) (car b)) (equals? (cdr a) (cdr b))))
	(else false)))

;; true
(equals? '(this is a list) '(this is a list))
;; false
(equals? '(this (is a) list) '(this (is a) list))
