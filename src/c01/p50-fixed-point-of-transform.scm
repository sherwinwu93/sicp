;; 继续抽象平均阻尼和牛顿法, 即由其他方程(零点或者无限迭代的不动点方程)transform为收敛的不动点方程
(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))
;; 平均阻尼
(load "p48-average-damp.scm")
(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (/ x y))
                            average-damp
                            1.0))
(sqrt 4)
;; 牛顿法
(load "p49-newton-transform.scm")
(define (sqrt x)
  (fixed-point-of-transform (lambda(y) (- (square y) x))
                            newton-transform
                            1.0))
(sqrt 16)
