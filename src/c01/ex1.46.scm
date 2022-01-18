;; 迭代式改进
;; iterative-improve, good-enough? improve, 返回lambda
;; 重新sqrt和fixed-point
(load-r "lib/math.scm")
(define (iterative-improve good-enough? improve)
  (lambda(first-guess)
    (define (try guess)
      (if (good-enough? guess)
	  guess
	  (try (improve guess))))
    (try first-guess)))


(define (fixed-point f first-guess)
  ((iterative-improve
    (lambda(y) (< (abs (- y (f y)))
		  0.00001))
    (lambda(y) (f y)))
   1.0))

(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))

(sqrt 4.0)
