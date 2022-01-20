(define (linear-combination a b x y)
  (+ (* a x) (* b y)))
;; 针对有理数, 更抽象的表达
(define (linear-combination a b x y)
  (add (mul a x) (mul b y)))
