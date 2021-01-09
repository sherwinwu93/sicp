;; 乘法的迭代
(define (double a)
  (/ a 0.5))
(define (halve a)
  (/ a 2.0))
(define (* a b)
  (cond ((= b 0) 0)
        ((even? b) (* (double a)
                      (halve b)))
        (else (+ a (* a
                      (- b 1))))))
(* 2 3)
