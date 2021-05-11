(load-r "c02/p99.scm")
;; a.中缀表达式
;; 改前缀运算,为中缀运算
(define (deriv exp var)
  (display exp)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))
;; 构造和式make-sum,addend,augend
(define (make-sum x y)
  (list x '+ y))
(define addend car)
(define augend caddr)
(define (sum? s)
  (and (pair? s)
       (eq? (cadr s) '+)))
(define s1 (make-sum 1 2))
(addend s1)
(augend s1)
(sum? s1)

;; product数据抽象:make-product,multiplier,multiplicand 
(define (make-product x y)
  (list x '* y))
(define multiplier car)
(define multiplicand caddr)
(define (product? p)
  (and (pair? p)
       (eq? (cadr p) '*)))
(define p1 (make-product 1 2))
(multiplier p1)
(multiplicand p1)
(product? p1)

(deriv '((x * x) + 3) 'x)

;; b.可以不带括号的中缀表达式
;;   (x + 3 * x + y)
(define (deriv exp var)
  (display exp)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))
;; 构造处理括号的表达式
;;  谓词nopair?,构造函数make-nopair,选择函数nopair
(define make-nopair identity)
(define (nopair? z)
  )
(define (nopair z)


