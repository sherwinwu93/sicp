
(load-r "c02/p76-convention-interface.scm")
;; 将树的操作归结为对它们分支的操作,再将这种操作归结为对分支的分支的操作,直到达到树的叶子
(define x (cons (list 1 2) (list 3 4)))
(count-leaves x)
(count-leaves (list 1 (list x x)))

(define (count-leaves t)
  (accumulate +
	      0
	      (map (lambda(sub-t)
		     (if (not (pair? sub-t))
			 1
			 (count-leaves sub-t)))
		   t)))

(load-r "c02/ex2.28-fringe.scm")
(define (count-leaves t)
  (accumulate (lambda(x y) (+ 1 y))
	      0
	      (fringe t)))
