;;
(load-r "lib/math.scm")
(load-r "c01/p34-fermat-test.scm")
(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (* (expmod base (/ exp 2) m)
		       (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))
;;假如exp为4
;; exp4
;; exp2,exp2
;; exp1, exp1, exp2
;; 1,1,exp1,exp1
;; 1,1,1,1
;; 因为exp/2的值未保留而重复计算,导致O(logN)->O(n)
