(load "ex1.11.scm")
;; 再增加百分比
(define (make-center-percent c p)
  (let ((w (/ (* c p) 100.0)))
    (make-center-width  c w)))
(define (percent i)
  (* 100 (/ (width i) (center i))))