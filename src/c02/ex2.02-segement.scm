(load-r "lib/math.scm")
(load-r "c02/ex2.02-point.scm")

(define (make-segment start-point end-point)
  (cons start-point end-point))
(define AB (make-segment A B))
(define BC (make-segment b c))

(define (start-segment segement)
  (car segement))

(define (end-segment segement)
  (cdr segement))
;; ----------------------------------------------------------------------------------------------------

(define (midpoint-segement segement)
  (let ((start-point (start-segment segement))
	(end-point (end-segment segement)))
    (make-point (average (x-point start-point) (x-point end-point))
		(average (y-point start-point) (y-point end-point)))))

(define (find-same-point segement point)
  (let ((start-point (start-segment segement))
	(end-point (end-segment segement)))
    (cond ((equal-point? start-point point) start-point)
	  ((equal-point? end-point point) end-point)
	  (else error-point))))

(define (find-diff-point segement point)
  (let ((start-point (start-segment segement))
	(end-point (end-segment segement)))
    (cond ((not (equal-point? start-point point)) start-point)
	  ((not (equal-point? end-point point)) end-point)
	  (else error-point))))

(define (find-same-point-by-segement source-segement segement)
  (let ((start-point (start-segment segement))
	(end-point (end-segment segement)))
    (let ((same-point (find-same-point source-segement start-point)))
      (if (not (equal-point? same-point error-point))
	  same-point
	  (find-same-point source-segement end-point)))))
(find-same-point-by-segement ab bc)

(define (square-length-segement segement)
  (let ((start (start-segment segement))
	(end (end-segment segement)))
    (let ((dx (- (x-point end) (x-point start)))
	  (dy (- (y-point end) (y-point start))))
      (+ (square dx) (square dy)))))

(define (length-segement segement)
  (sqrt (square-length-segement segement)))
(square-length-segement bc)

(print-point (midpoint-segement (make-segment A B)))

;; --------------------testcase
