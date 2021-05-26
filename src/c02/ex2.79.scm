(load-r "c02/p129-generic-operator.scm")
(define (atom? x) (not (pair? x)))
;; 安装equ到通用算术包里.能处理常规数`有理数和复数
(define (install-equ?-package)
  ;; interval-equ?
  (define (equ? x y)
    (cond ((and (atom? x) (atom? y)) (eq? x y))
          ((and (pair? x) (pair? y)) (and (eq? (car x) (car y))
                                          (equ? (cdr x) (cdr y))))
          (else false)))
  ;; interface to rest of the system
  (put 'equ? '(scheme-number scheme-number) equ?)
  (put 'equ? '(rational rational) equ?)
  (put 'equ? '(complex complex) equ?)
  )
(define equ?
  (lambda (x y) (apply-generic 'equ? x y)))
(install-equ?-package)

(equ? (make-scheme-number 1) (make-scheme-number 1))
(equ? (make-rational 1 2) (make-rational 2 4))
(equ? (make-from-real-imag 1 2) (make-from-real-imag 2 2))
