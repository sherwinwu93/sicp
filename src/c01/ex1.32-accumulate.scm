;; ex1.32-accumulate.scm 积累
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
		(accumulate combiner
			    null-value
			    term
			    (next a)
			    next
			    b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (sum-integers a b)
  (sum (lambda(x) x)
       a
       1+
       b))
(sum-integers 1 10)
;; ----------------
(define (factorial term a next b)
  (accumulate * 1 term a next b))

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
