(define (square-list items)
  (define (iter things answer)
    (if (null? things)
	answer
	(iter (cdr things)
	      (cons (square (car things))
		    answer))))
  (iter items ()))

(square-list (list 1 2 3 4))
;; 顺序为啥是反的? 因为 (cons (square (car things)) answer) answer每一步都在后面

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
	answer
	(iter (cdr things)
	      (cons answer (square (car things))))))
  (iter items ()))
;; 因为(cons list 2) 结果是 (list 2) 例如 (1) ((1) 2)
;; 用append
