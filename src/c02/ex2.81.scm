(load-r "c02/g-generic-operator.scm")
;; Louis认为:两参数类型相同时,apply-generic也试图做类型强制.
;;      推论:需要每个类型强制为自己的类型,如下
;; (define (scheme-number->scheme-number n) n)
;; (define (complex->complex z) z)
;; (put-coercion 'scheme-number 'scheme-number
;;               scheme-number->scheme-number)
;; (put-coercion 'complex 'complex
;;               complex->complex)

;; A.如果安装了Louis的强制过程,调两相同传参时,表格没有相应操作,什么情况?例如
(define (exp x y) (apply-generic 'exp x y))
;; 再放入scheme-number包
(put 'exp '(scheme-number scheme-number)
     (lambda (x y) (attach-tag 'scheme-number (expt x y))))
;; 对复数调用exp出现什么情况?

;; 答:
;; 没有安装Louis的强制过程.正常报错
(exp (make-scheme-number 1) (make-scheme-number 2))
;; 安装Louis的强制过程,会无限递归
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(put-coercion 'scheme-number 'scheme-number
              scheme-number->scheme-number)
(put-coercion 'complex 'complex
              complex->complex)
(exp (make-from-real-imag 3 4) (make-from-real-imag 2 1))
(+ 1 2)

;; B.Louis 并没有修正同样类型参数的强制问题
;; C.修改apply-generic,使之不会强制两相同类型参数
;; 见g-apply-generic.scm
