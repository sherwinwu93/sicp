;; sum.scm
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	 (sum term (next a) next b))))
;; ex1.30-sum-iter.scm
(define (sum term a next b)
  (define (iter i ans)
    (if (> i b)
	ans
	(iter (next i)
	      (+ ans (term i)))))
  (iter a 0))

(define (sum-integers a b)
  (sum (lambda(x) x)
       a
       1+
       b))
(sum-integers 1 10)
