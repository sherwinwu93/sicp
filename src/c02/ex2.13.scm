(load (absolute "c02/ex2.12.scm"))
;; 误差证明问题,用lower-bound指代upper-bound,计算出来
;; 4P/(1-P)^2

;; par1
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

;; par2
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define r1 (make-interval 3.5 3.5))
(define r2 (make-interval 3.5 4.5))
(par1 r1 r2)
(par2 r1 r2)
