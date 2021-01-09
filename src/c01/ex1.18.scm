;; 前置条件
;; havle double
(load "./halve-double.scm")
;; logn的求法
(define (* a b)
  (multi-iter a b 0))
(define (multi-iter a b s)
  (cond ((= b 0) s)
        ((even? b)(multi-iter (double a)
                     (halve b)
                     s))
        (else (multi-iter a
                 (- b 1)
                 (+ s a)))))
(* 4 5)
