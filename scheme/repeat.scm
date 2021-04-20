(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1)))))
(fact 10)

(define (list*2 ls)
  (if (null? ls)
      '()
      (cons (* 2 (car ls))
	    (list*2 (cdr ls)))))
(list*2 '(0 1 2))
