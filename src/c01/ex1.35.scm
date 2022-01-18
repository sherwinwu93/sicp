;; ex1.35.scm
;; 证明x->1+1/x的不动点是黄金分割率
(load-r "lib/fixed-point.scm")
(define golden-ratio
  (fixed-point (lambda(x) (+ 1 (/ 1 x)))
	       1.0))

golden-ratio
