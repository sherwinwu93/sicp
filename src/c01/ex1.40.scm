(load-r "c01/p50-newton-method.scm")
(load-r "lib/math.scm")
(define (cubic a b c)
  (lambda(x)
    (+ (cube x)
       (* a (square x))
       (* b x)
       c)))

(define (f a b c)
  (newtons-method (cubic a b c) 1))

(f 1 1 -1)
