;; ex3.12
;; 构造法
(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))
(append (list 1 2) (list 3 4))
;; 改变法
(define (append! x y)
  (if (null? x)
      y
      (begin (set-cdr! (last-pair x) y)
	     x)))
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))
(append! (list 1 2) (list 3 4))
;; 交互
(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
;; (a b c d)
z
;; (b)
(cdr x)

(define w (append! x y))
;; (a b c d)
w
;; (b c d)
(cdr x)
