(define (equ? x y)
  (cond ((and (pair? x) (pair? y))
	 (and (eq? (car x) (car y))
	      (equ? (cdr x) (cdr y))))
	((and (not (pair? x)) (not (pair? y)))
	 (eq? x y))
	(else false)))