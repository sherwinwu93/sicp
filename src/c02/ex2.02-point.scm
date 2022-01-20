;; 定义make-point` x-point`y-point
(define (make-point x y)
  (cons x y))
(define A (make-point 0 2))
(define B (make-point 0 0))
(define C (make-point 3 0))
(define D (make-point 3 2))
(define E (make-point 3 1))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))
;; ----------------------------------------------------------------------------------------------------

(define (equal-point? point another-point)
  (and (= (x-point point) (x-point another-point))
       (= (y-point point) (y-point another-point))))

(define error-point (make-point -99999 -99999))

(define (print-point point)
  (newline)
  (display "(")
  (display (x-point point))
  (display ",")
  (display (y-point point))
  (display ")"))

(x-point A)
(y-point A)
(equal-point? A E)
error-point
(print-point error-point)
