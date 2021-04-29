;; 跨过0的区间意义不清楚
(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))
;; 修改后
(define (div-interval x y)
  (let ((yl (lower-bound y))
        (yu (upper-bound y)))
    (if (or (= yl 0) (= yu 0))
        (error "div zero")
        (mul-interval x
                      (make-interval (/ 1.0 (upper-bound y))
                                     (/ 1.0 (lower-bound y)))))))
(define x (make-interval 1 2))
(define y (make-interval 1 3))
(div-interval x y)
