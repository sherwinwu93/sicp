;; 写出检查是否包含环的过程
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define (loop? 1st)
  (let ((identify (cons '() '())))
    (define (iter remain-list)
      (cond ((null? remain-list) false)
	    ((eq? (car remain-list) identify) true)
	    (else
	     (set-car! remain-list identify)
	     (iter (cdr remain-list)))))
    (iter 1st)))



(loop? (make-cycle (list 'a 'b 'c)))
(loop? (list 'a 'b 'c))
