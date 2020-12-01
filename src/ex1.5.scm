(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))
;;!stackoverflow
(test 0 (p))
