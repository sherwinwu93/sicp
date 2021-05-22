;; rules
(define algebra-rules
  '(
    ( ((? op) (?c e1) (?c e2))         (: (op e1 e2))               )
    ( ((? op) (? e1) (?c e2))          ((: op) (: e2) (: e1))       )
    ( (+ 0 (? e))                      (: e)                        )
    ( (* 1 (? e))                      (: e)                        )
    ( (* 0 (? e))                      0                            )
    ( (* (?c e1) (* (?c e2) (? e3)))   (* (: (* e1 e2)) (: e3))     )
    ( (* (? e1) (* (?c e2) (? e3)))    (* (: e2) (* (: e1) (: e3))) )
    ( (* (* (? e1) (? e2)) (? e3))     (* (: e1) (* (: e2) (: e3))) )
    ( (+ (?c e1) (+ (?c e2) (? e3)))   (+ (: (+ e1 e2)) (: e3))     )
    ( (+ (? e1) (+ (?c e2) (? e3)))    (+ (: e2) (+ (: e1) (: e3))) )
    ( (+ (+ (? e1) (? e2)) (? e3))     (+ (: e1) (+ (: e2) (: e3))) )
    ( (+ (* (?c c) (? a)) (* (?c d) (? a)))
      (* (: (+ c d)) (: a))        )
    ( (* (? c) (+ (? d) (? e)))        (+ (* (: c) (: d))
                                          (* (: c) (: e)))          )
    ))

;; matcher
;; 例如 pattern: (+ (* (? x) (? y)) (? y))
;;      expression: (+ (* 3 x) x)
;; (match '(+ (* (? x) (? y)) (? y)) '(+ (* 3 x) x) (empty-dictionary))

(define (match pat exp dict)
  ;; (display "match")
  ;; (display dict)
  ;; (newline)
  (cond ((eq? dict 'failed) 'failed) ;; 传递失败
        ((atom? pat)
         ;; atomic patterns
         ;; + : +
         (if (atom? exp)
             (if (eq? pat exp)
                 dict
                 'failed)
             'failed))
        ;; Pattern variable clause
        ;; ?c : 3
        ((arbitary-constant? pat)
         (if (constant? exp)
             (extend-dict pat exp dict)
             'failed))
        ;; ?v  : (任意变量)
        ((arbitary-variable? pat)
         (if (variable? exp)
             ;; 如果dict的pat键已有值,则会failed
             (extend-dict pat exp dict)
             'failed))
        ;; (? x) : 任意变量或任意值
        ((arbitray-expression? pat)
         ;; 如果dict的pat键已有值,则会failed
         (extend-dict pat exp dict))
        ((atom? exp) 'failed)
        ;; 同时遍历pattern和expression两棵树
        (else
         (match (cdr pat)
                (cdr exp)
                (match (car pat)
                       (car exp)
                       dict)))))

;; 实例化器
(define (instantiate skeleton dict)
  ;; (display "instantiate")
  ;; (display skeleton)
  (define (loop s)
    (cond ((atom? s) s)
          ;; 有:号,就是骨架求值
          ((skeleton-evaulation? s)
           (evaluate (eval-exp s) dict))
          (else (cons (loop (car s))
                      (loop (cdr s))))))
  (loop skeleton))

;; 求值程序
(define (evaluate form dict)
  ;; (cond ((atom? form) (display ""))
  ;;       (else (display "EVALUATE")
  ;;             (display "FORM")
  ;;             (display form)
  ;;             (display "dict")
  ;;             (display dict)))
  (cond ( (atom? form) (lookup form dict))
        (else
         ;; (newline)
         ;; (display "")
         ;; (display (car form))
         (apply
          (eval (lookup (car form) dict)
                user-initial-environment)
          (map (lambda(v)
                 (lookup v dict))
               (cdr form))
       ))))

(apply (eval '+ user-initial-environment)
       (list '2 '4))
;; GIGO: garbage in, garbage out
(define (simplifier the-rules)
  ;; (define (simplify-exp exp)
  ;;   (display "simplify-exp")
  ;;   (display exp)
  ;;   (newline)
  ;;   (try-rules (if (compound? exp)
  ;;                  (simplify-parts exp)
  ;;                  exp)))
  (define (simplify-exp exp)
    ;; (display "simplify-exp")
    ;; (display exp)
    ;; (newline)
    (try-rules (if (compound? exp)
                   (map simplify-exp exp)
                   exp)))
  ;; (define (simplify-parts exp)
  ;;   (if (null? exp)
  ;;       '()
  ;;       (cons (simplify-exp (car exp))
  ;;             (simplify-parts (cdr exp)))))
  (define (try-rules exp)
    (define (scan rules)
      (if (null? rules)
          exp
          (let ((dict
                 (match (pattern (car rules))
                        exp
                        (empty-dictionary))))
            (cond ((eq? dict 'failed) (scan (cdr rules)))
                  (else
                   (display "RULE")
                   (display (car rules))
                   (display "DICT")
                   (display dict)
                   (newline)
                   (simplify-exp
                         (instantiate
                          (skeleton (car rules))
                          dict)))))))
    (scan the-rules))
  simplify-exp)

;; 字典
(define (empty-dictionary) '())

(define (extend-dict pat dat dict)
  (let ((vname (variable-name pat)))
    (let ((v (assq vname dict)))
      (cond ((not v)
             (cons (list vname dat) dict))
            ((eq? (cadr v) dat) dict)
            (else 'failed)))))

(define (lookup var dict)
  (let ((v (assq var dict)))
    (if (null? v) var (cadr v))))

(define (compound? exp) (pair? exp))
(define (constant? exp) (number? exp))
(define (variable? exp) (atom? exp))
(define (pattern rule) (car rule))
(define (skeleton rule) (cadr rule))

(define (arbitary-constant? exp)
  (if (pair? exp)
      (eq? (car exp) '?c)
      false))
(define (arbitray-expression? exp)
  (if (pair? exp)
      (eq? (car exp) '?)
      false))
(define (arbitary-variable? exp)
  (if (pair? exp)
      (eq? (car exp) '?v)
      false))

(define (variable-name pat) (cadr pat))

(define (skeleton-evaulation? pat)
  (if (pair? pat)
      (eq? (car pat) ':)
      false))

(define (eval-exp evaluation)
  (cadr evaluation))

(define algsimp (simplifier algebra-rules))

(algsimp '(* (+ 2 3) (* 4 5)))

(define deriv-rules
  '(( (dd (?c c) (? v))              0                                )
    ( (dd (?v v) (? v))              1                                )
    ( (dd (?v u) (? v))              0                                )
    ( (dd (+ (? x1) (? x2)) (? v))   (+ (dd (: x1) (: v))
                                        (dd (: x2) (: v)))            )
    ( (dd (* (? x1) (? x2)) (? v))   (+ (* (: x1) (dd (: x2) (: v)))
                                        (* (dd (: x1) (: v)) (: x2))) )
    ( (dd (** (? x) (?c n)) (? v))   (* (* (: n)
                                           (** (: x) (: (- n 1))))
                                        (dd (: x) (: v)))             )
    ))

(define dsimp (simplifier deriv-rules))

(define scheme-rules
  '(( (square (?c n))               (: (* n n))                      )
    ( (fact 0)                      1                                )
    ( (fact (?c n))                 (* (: n) (fact (: (- n 1))))     )
    ( (fib 0)                       0                                )
    ( (fib 1)                       1                                )
    ( (fib (?c n))                  (+ (fib (: (- n 1)))
                                       (fib (: (- n 2))))            )
    ( ((? op) (?c e1) (?c e2))      (: (op e1 e2))                   ) ))

(define scheme-evaluator (simplifier scheme-rules))

(define (atom? x) (not (pair? x)))
