;; (double f) (f x) return lambda
;; (double inc) (lambda(x) (inc (inc x)))
(define (double f)
  (lambda(x)
    (f (f x))))
(((double (double double)) 1+) 5)
