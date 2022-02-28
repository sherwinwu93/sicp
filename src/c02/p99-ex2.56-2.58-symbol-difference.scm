;; wishful thinking
;; (variable? e)
;; (same-variable? v1 v2)

;; (sum? e)
;; 被加数
;; (addend e)
;; 加数
;; (augend e)
;; (make-sum a1 a2)

;; (product? e)
;; (multiplier e)
;; (multiplicand e)
;; (make-product m1 m2)
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? x a)
  (and (number? x) (= x a)))

(cons 1 (list 2 3))

;; ------------------------------------------------------------
(define (make-sum a1 a2 . arr)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (=number? a1 0) (=number? a2 0)) (+ a1 a2))
	(else (list '+ a1 a2))))
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s)
  (caddr s))

;; ------------------------------
;; ex2.57
(load-r "lib/single-operand.scm")
;; apply
(define (make-sum a1 . a2)
  (if (single-operand? a2)
      (let ((a2 (car a2)))
	(cond ((=number? a1 0) a2)
	      ((=number? a2 0) a1)
	      ((and (number? a1) (number? a2))
	       (+ a1 a2))
	      (else
	       (list '+ a1 a2))))
      (cons '+ (cons a1 a2))))
(define (sum? x)
  (and (pair? x)
       (eq? (car x) '+)))
(define (addend s)
  (cadr s))
(define (augend s)
  (let ((tail-operand (cddr s)))
    (if (single-operand? tail-operand)
	(car tail-operand)
	(apply make-sum tail-operand))))
(define s1 (make-sum 'a 'b 'c))
(addend s1)
(augend s1)
;; ------------------------------------------------------------
(define (make-product m1 m2)
  (cond ((=number? m1 0) 0)
	((=number? m1 1) m2)
	((=number? m2 0) 0)
	((=number? m2 1) m1)
	((and (number? m1) (number? m2)) (* m1 m2))
	(else (list '* m1 m2))))
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define multiplier cadr)
(define multiplicand caddr)
;; ------------------------------
;; ex2.57
(define (make-product m1 . m2)
  (if (single-operand? m2)
      (let ((m2 (car m2)))
	(cond ((=number? m1 0) 0)
	      ((=number? m1 1) m2)
	      ((=number? m2 0) 0)
	      ((=number? m2 1) m1)
	      ((and (number? m1) (number? m2)) (* m1 m2))
	      (else (list '* m1 m2))))
      (cons '* (cons m1 m2))))
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define multiplier cadr)
(define multiplicand
  (lambda(p)
    (let ((tail-operand (cddr p)))
      (if (single-operand? tail-operand)
	  (car p)
	  (apply make-product tail-operand)))))
(define p1 (make-product 'a 'b 'c))
(multiplicand p1)

;; ------------------------------
;; ex2.56
(define (make-exponentiation b e)
  (cond ((= e 0) 1)
	((= e 1) b)
	(else (list '** b e))))
(define (base p)
  (cadr p))
(define (exponent p)
  (caddr p))
(define (exponentiation? p)
  (eq? (car p) '**))
;; (exponentiation? p)
;; (base p)
;; (exponent p)
;; (make-exponentiation b e)

;; ------------------------------------------------------------
(define (deriv exp var)
  (cond((number? exp) 0)
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
       ;; ------------------------------
       ;; 2.56
       ;; ((exponentiation? exp)
       ;; 	(make-product
       ;; 	 (make-product (exponent exp)
       ;; 		       (make-exponentiation (base exp) (- (exponent exp) 1)))
       ;; 	 (deriv (base exp) var)))
       (else
	(error "unknown expression type -- DERIV" exp))))

(deriv '(+ x 3) 'x)
;; (deriv '(x + 3) 'x)
(deriv '(* x y) 'x)
;; (deriv '(x * y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)
;; ------------------------------
;; ex2.58 中缀表达法
;; (define (make-product m1 m2)
;;   (cond ((=number? m1 0) 0)
;; 	((=number? m1 1) m2)
;; 	((=number? m2 0) 0)
;; 	((=number? m2 1) m1)
;; 	((and (number? m1) (number? m2)) (* m1 m2))
;; 	(else (list m1 '* m2))))
;; (define (product? p)
;;   (and (pair? p)
;;        (eq? (cadr p) '*)))
;; (define (multiplier p)
;;   (car p))
;; (define (multiplicand p)
;;   (caddr p))

;; (define (make-sum a1 a2)
;;   (cond ((=number? a1 0) a2)
;; 	((=number? a2 0) a1)
;; 	((and (number? a1) (number? a2)) (+ a1 a2))
;; 	(else (list a1 '+ a2))))
;; (define (sum? s)
;;   (and (pair? s)
;;        (eq? (cadr s) '+)))
;; (define (addend s)
;;   (car s))
;; (define (augend s)
;;   (caddr s))

;; (deriv '(x + 3 * (x + y + 2)) 'x)
;; ------------------------------
;; ex2.58.b
;; 如果要使用标准写法的话,没办法通过修改表示法的方式
;; 因为求导的顺序依赖于符号的优先级.比如*>+,而我们的数据抽象,只单独针对*或者+,没办法处理两者的关系.必然要修改deriv
;; 一种方案: 在deriv 将'(x + 3 * (x+y+2)) -> (x + (3 * (x + (y + 2)))).尚不知道使用函数式编程解决
