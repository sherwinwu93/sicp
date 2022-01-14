;; ex1.31-factorial.scm
(define (factorial term a next b)
  (if (> a b)
      1
      (* (term a)
	 (factorial term
		    (next a)
		    next
		    b))))

(define (pi-sum a b)
  (define (term x)
    (cond ((even? x) (/ (+ x 2)
			(+ x 1)))
	  (else (/ (+ x 1)
		   (+ x 2)))))
(* 1.0
   (factorial term
	      a
	      1+
	      b)))
(pi-sum 1 10000)
;; 迭代方法
(define (factorial term a next b)
  (define (iter start ans)
    (if (> start b)
	ans
	(iter (next start)
	      (* (term start)
		 ans))))
  (iter a 1))
