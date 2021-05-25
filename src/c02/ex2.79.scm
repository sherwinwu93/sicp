(load-r "c02/p129-generic-arithmetic-operation.scm")
;; 定义通用型相等equ?,检查两个数是否相等
(define (install-equ-package)
  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y)
         (eq? x y)))
  (put 'equ? '(rational rational)
       (lambda (x y)
         (and (eq? (numer x) (numer y))
              (eq? (denom x) (denom y)))))
  (put 'equ? '(complex complex)
       (lambda (x y)
         (and (eq? (real-part x)
                   (real-part y))
              (eq? (imag-part x)
                   (imag-part y)))))
  'done)
(install-equ-package)

(apply-generic 'equ? ((get 'make 'scheme-number) 1) ((get 'make 'scheme-number) 1))
(apply-generic 'equ? ((get 'make 'scheme-number) 1) ((get 'make 'scheme-number) 2))

(apply-generic 'equ? ((get 'make 'rational) 1 2) ((get 'make 'rational) 1 2))
(apply-generic 'equ? ((get 'make 'rational) 1 2) ((get 'make 'rational) 2 4))

(apply-generic 'equ? ((get 'make-from-real-imag 'complex) 1 2) ((get 'make-from-real-imag 'complex) 1 2))
(apply-generic 'equ? ((get 'make-from-real-imag 'complex) 1 2) ((get 'make-from-real-imag 'complex) 2 2))

