;; Church(丘奇)计数
(define zero (lambda(f) (lambda(x) x)))
(define (add-1 n)
  (lambda(f) (lambda(x) (f ((n f) x)))))
;; 定义one和two
(define one (lambda(f) (lambda(x) (f x))))
(define two (lambda(f) (lambda(x) (f (f x)))))
;; 给出+的直接定义
(define (add-church m n)
  (lambda(f) (lambda(x) ((m f) ((n f) x)))))
(add-church one two)
