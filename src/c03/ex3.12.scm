(load "init")
;; 拼接表的过程:构造函数
(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))
;; append!:改变函数
;; 将x的最后的pair的cdr改变为y
(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)
;; last-pair
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))
;; 交互
(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
z
'(a b c d)
(cdr x)
;; <response> (b)
(define w (append! x y))
w
'(a b c d)
(cdr x)
;; <response> (b c d)
;; 缺少的response是什么?画出盒子指针图像解释它
