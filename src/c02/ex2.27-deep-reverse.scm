;; 深度反转
(define x (list (list 1 2) (list 3 4)))
;; ((3 4) (1 2))
(reverse x)
;; 深度反转
(deep-reverse x)
((4 3) (2 1))

(define (deep-reverse list)
  (cond ((null? list) ())
	((not (pair? list)) list)
	(else
	 (reverse
	  (map deep-reverse list)))))
