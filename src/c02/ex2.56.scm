(load-r "c02/p99.scm")

;; 扩充求导规则: 乘幂的求导规则
;;   定义过程:exponentiation?
;;           :base
;;           :exponent
;;           :make-exponentiation
(define (deriv exp var)
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
        ((exponentiation? exp)
         (make-product (exponent exp)
                       (make-product (make-exponentiation (base exp)
                                                   (make-sum (exponent exp)
                                                             -1))
                                     (deriv (base exp) var))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(define (make-exponentiation x y)
  (list '** x y))
(define (exponentiation? exp)
  (and (pair? exp)
       (eq? (car exp) '**)))
(define base cadr)
(define exponent caddr)
;; test
(define exp (make-exponentiation 'e 'n))
(exponentiation? exp)
(base exp)
(exponent exp)
(deriv '(** x 3) 'x)
(deriv '(+ (** x 3) (* 10 x)) 'x)
