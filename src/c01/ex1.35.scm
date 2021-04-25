(load "p46-fixed-point.scm")
;; 求黄金分割律
(fixed-point (lambda(x) (+ 1 (/ 1 x))) 1.0)
