;; pair的另一种过程性表示方式, 验证对任意的x和y,(car (cons x y))->x
(define (cons x y)
  (lambda(m) (m x y)))

(define (car x)
  (z (lambda (p q) p)))
;; 代换模型
(car (cons x y))
((cons x y) (lambda(p q) p))
((lambda(m) (m x y)) (lambda(p q) p))
((lambda(p q) p) x y)
x

;; 对应cdr
(define (cdr x)
  (z (lambda (p q) q)))
(cdr (cons x y))
((cons x y) (lambda (p q) q))
((lambda(m) (m x y)) (lambda (p q) q))
((lambda(p q) q) x y)
y
