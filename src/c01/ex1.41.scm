;; 写出过程double,传参:一个过程,返回:将传参过程应用两次的过程
;; ((double inc) 1) ((inc (inc)) 1) (inc (inc 1)) (inc 2) 3
(define (double f)
  (lambda (x)
    (f (f x))))
(define (inc x)
  (1+ x))
((double inc) 1)
((lambda (x) (inc (inc x))) 1)

(((double (double double)) inc) 5)
(((double (lambda(x) (double (double x)))) inc) 5)
(((lambda(y) ((lambda(x) (double (double x)))
              ((lambda(x) (double (double x)))
               y))) inc) 5)

(((lambda(y) ((lambda(x) (double (double x)))
              ((lambda(x) (double (double x)))
               y))) inc) 5)

(((lambda(x) (double (double x)))
  ((lambda(x) (double (double x)))
   inc)) 5)

(((lambda(x) (double (double x)))
  (double (double inc))) 5)

((double (double (double (double inc)))) 5)
;; 21
;; 一定要构建起抽象的概念
