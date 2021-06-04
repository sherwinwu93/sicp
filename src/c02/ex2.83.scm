(load-r "c02/g-generic-operator.scm")

;; 类型塔情况下,安装通用的raise操作
;; 安装raise过程
(define (install-raise-package)
  (define (scheme-number->rational x)
    (make-rational (contents x) 1))
  (define (rational->complex x)
    (make-from-real-imag x 0))
  (put-coercion 'raise 'scheme-number scheme-number->rational)
  (put-coercion 'raise 'rational rational->complex)
  )
(define raise-package (install-raise-package))
((get-coercion 'raise 'scheme-number) (make-scheme-number 1))
((get-coercion 'raise 'rational) (make-rational 1 2))

