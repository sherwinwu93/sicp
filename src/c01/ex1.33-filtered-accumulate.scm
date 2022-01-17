(load-r "lib/math.scm")
(define (filtered-accumulate filter combiner null-value term a next b)
  (cond ((> a b) null-value)
	((not (filter a))
	 (filtered-accumulate filter combiner null-value term (next a) next b))
	(else
	 (combiner (term a)
		   (filtered-accumulate filter combiner null-value term (next a) next b)))))
(load-r "c01/p33-smallest-divisor.scm")
(load-r "lib/base-term.scm")
;;a. 求出区间a到b中所有素数之和
(define (sum-primes a b)
  (filtered-accumulate prime? + 0 identify a 1+ b))
(sum-primes 1 100)
;; b.小于n的所有与n互素的正整数之积
(define (factorial-coprime n)
  (define (coprime i)
    (= (gcd i n) 1))
  (filtered-accumulate coprime * 1 identify 1 1+ n))
(factorial-coprime 10)
(factorial-coprime 100)

;; b
(define (filter-accumulate filter combiner null-value term a next b)
  (define (iter start ans)
    (cond ((> start b) ans)
	  ((not (filter start))
	   (iter (next start) ans))
	  (else
	   (iter (next start)
		 (combiner (term start) ans)))))
  (iter a null-value))
