;; ex3.13
(load-r "c03/ex3.12.scm")

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
(define z (make-cycle (list 'a 'b 'c)))
(last-pair z)
;; stackoverflow
