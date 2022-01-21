;; 将树的操作归结为对它们分支的操作,再将这种操作归结为对分支的分支的操作,直到达到树的叶子
(define x (cons (list 1 2) (list 3 4)))
(length x)
(count-leaves x)
(list x x)
(length (list x x))
(count-leaves (list x x))

(define (count-leaves x)
  (cond ((null? x) 0)
	((not (pair? x)) 1)
	(else
	 (+ (count-leaves (car x))
	    (count-leaves (cdr x))))))
