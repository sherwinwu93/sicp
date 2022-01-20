(load-r "c02/ex2.02-segement.scm")
;; 定义矩形,计算周长和面积
(define (make-rectangle bc ab)
  (cons bc ab))

(define bc (make-segment b c))
(define be (make-segment b e))
(define ab (make-segment a b))
(define ac (make-segment a c))
(define bd (make-segment b d))
(define rec (make-rectangle ac bd))
(perimeter-rectangle rec)
(area-rectangle rec)

(define (rectangle-long rectangle)
  (car rectangle))
(define (rectangle-width rectangle)
  (cdr rectangle))
(define (long-length rectangle)
  (length-segement (rectangle-long rectangle)))
(define (width-length rectangle)
  (length-segement (rectangle-width rectangle)))



;; --------------------------------------------------

(define (perimeter-rectangle rectangle)
  (* 2 (+ (long-length rectangle) (width-length rectangle))))

(define (area-rectangle rectangle)
  ( * (long-length rectangle) (width-length rectangle)))

;; another implement
(define (make-rectangle ac bd)
  (cons ac bd))
(define (long-length rectangle)
  (let ((ac (car rectangle))
	(bd (cdr rectangle)))
    (let ((b (start-segment bd))
	  (c (end-segment ac)))
      (length-segement (make-segment b c)))))
(define (width-length rectangle)
  (let ((ac (car rectangle))
	(bd (cdr rectangle)))
    (let ((a (start-segment ac))
	  (b (start-segment bd)))
      (length-segement (make-segment a b)))))
