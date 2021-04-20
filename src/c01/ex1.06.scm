(load "./sqrt-iter.scm")
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
;;测试程序
(new-if (= 2 3) 0 5)
(new-if (= 0 0) 0 5)

;; 报错maximum recursion depth exceeded
;; 超过递归过深
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
(sqrt-iter 1 2.0)

;; 用trace跟踪,发现调用过多
(trace sqrt-iter)
(sqrt-iter 1 9.0)

;; new-if不可以, 因为new-if只是普通过程,而if则是关键字.
;; if只会对分支求值,而new-if根据正则序会传入时就求值,then-clause和else-clause都会被求值
;; 这样就不是单纯的尾递归了
(if #t (display "good") (display "bad"))
(new-if #t (display "good") (display "bad"))

