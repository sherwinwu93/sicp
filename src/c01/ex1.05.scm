(define (p) (p))
;; p
(define (test x y)
  (if (= x 0)
      0
      y))
;; test
;;应用序,就会无限递归
(test 0 (p))


































