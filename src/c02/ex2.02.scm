;; 平面上线段的表示问题
;; 线段用起点和终点表示:make-segment,start-segment,end-segment

;; 点用pair表示:make-point,x-point,y-point
;;             由此定义出midpoint-segment
(define (average x y)
  (/ (+ x y) 2))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ".")
  (display (y-point p))
  (display ")"))

;; make-segment
(define (make-segment p q)
  (cons p q))
;; start-segment
(define (start-segment s)
  (car s))
;; end-segment
(define (end-segment s)
  (cdr s))

;; make-point
(define (make-point x y)
  (cons x y))
;; x-point
(define (x-point p)
  (car p))
;; y-point
(define (y-point p)
  (cdr p))

;; 以线段为参数,返回线段的中点
(define (midpoint-segement s)
  (let ((p (start-segment s))
        (q (end-segment s)))
    (make-point (average (x-point p) (x-point q))
                (average (y-point p) (y-point q)))))
(define p (make-point 1 2))
(define q (make-point 2 3))
(define s (make-segment p q))
(print-point (midpoint-segement s))
