
(define (assoc key records)
  (cond ((null? records) false)
	((eq? key (caar records)) (car records))
	(else (assoc key (cdr records)))))
