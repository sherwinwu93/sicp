;; e-2的连分式展开
;; 分式中Ni全是1,D1为1,2,1,1,4,1,1,6,1,1,8
;; 根据1.37,写出这个连分式的过程
(load (absolute "c01/ex1.37.scm"))
(define (e-2 k)
  (define (n i) 1.0)
  (define (d i)
    (let ((r (remainder i 3)))
      (cond ((= r 1) 1.0)
            ((= r 2) (* 2.0
                        (+ (/ (- i 2) 3)
                           1)))
            ((= r 0) 1.0))))
  (cont-frac n d k))
(e-2 10000)
