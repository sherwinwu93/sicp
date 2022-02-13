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

;; ------------------------------------------------------------
(define (make-sum a1 . a2)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (=number? a1 0) (=number? a2 0)) (+ a1 a2))
	(else (list '+ a1 a2))))
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s)
  (let ((remain (cadr s)))
    (if (null? (cdr remain))
	(car remain)
	(make-sum (car remain) (cadr remain)))))
(define s (make-sum 'a 'b 'c))
(addend s)
(augend s)

;; ------------------------------------------------------------
(define (make-product m1 m2)
  (cond ((=number? m1 0) 0)
	((=number? m1 1) m2)
	((=number? m2 0) 0)
	((=number? m2 1) m1)
	(else (list '* m1 m2))))
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define multiplier cadr)
(define multiplicand caddr)

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
       ((exponentiation? exp)
	(make-product
	 (make-product (exponent exp)
		       (make-exponentiation (base exp) (- (exponent exp) 1)))
	 (deriv (base exp) var)))
       (else
	(error "unknown expression type -- DERIV" exp))))

(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)
