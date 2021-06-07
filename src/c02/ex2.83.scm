;; 写出过程raise:将类型的对象提升到塔中上面一层
(define (install-scheme-number-raise-package)
  (define (raise x)
    (make-rational x 1))
  (put 'raise '(scheme-number) raise))
(define scheme-number-raise-package (install-scheme-number-raise-package))

(define (install-rational-raise-package)
  (define (raise x)
    (make-from-real-imag x 0)
    )
  (put 'raise '(rational) raise))
(define rational-raise-package (install-rational-raise-package))

((get 'raise '(scheme-number)) (make-scheme-number 1))
((get 'raise '(rational)) (make-rational 1 3))
