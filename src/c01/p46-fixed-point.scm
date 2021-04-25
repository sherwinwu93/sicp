;; 不动点; f(x)=x
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define tolerance 0.00001)

;; cos的不动点
(fixed-point cos 1.0)
;; y=siny+cosy的不动点
(fixed-point (lambda(y) (+ (sin y)
                           (cos y)))
             1.0)
;; sqrt(x)的值是x/y的平均阻尼的不动点
(define (sqrt x)
  (fixed-point (average-damp (lambda(y) (/ x y))) 1.0))

(define (average-damp f)
  (lambda(y) (average (f y) y)))
