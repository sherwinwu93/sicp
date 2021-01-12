(define (f x y z)
  (if (> x y)
      (if (> y z)
          (+ x y)
          (+ x z))
      (if (> x z)
          (+ y x)
          (+ y z))))
;; f
(f 1 2 3)
;; 5
(f 3 2 5)
;; 8
