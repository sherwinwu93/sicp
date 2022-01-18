(load-r "c01/ex1.42-compose.scm")
(define (repeated f n)
  (define (iter ans i)
    (if (= i 0)
	ans
	(iter (compose f ans)
	      (- i 1))))
  (iter f (- n 1)))
;;625
((repeated square 2) 5)
