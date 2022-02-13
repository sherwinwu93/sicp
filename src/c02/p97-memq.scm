(define (memq item x)
  (cond ((null? x) false)
	((eq? item (car x)) true)
	(else (memq item (cdr x)))))

(memq 'apple '(pear banana prune))
(memq 'apple '(x (apple sauce) y apple pear))
