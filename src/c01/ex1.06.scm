(load "./sqrt-iter.scm")
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
;;new-if不可以
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
(sqrt-iter 1 2.0)
;; 报错maximum recursion depth exceeded
;; 超过递归过深
