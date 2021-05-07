(load (absolute "c02/ex2.13.scm"))
;; lem是对的
(define A (make-center-percent 37 0.00001))
(define B (make-center-percent 79 0.000003))
;; 百分比越小.误差越小
(div-interval A A)
(div-interval A B)
