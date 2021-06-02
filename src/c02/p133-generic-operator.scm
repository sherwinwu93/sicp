(load-r "c02/p186-make-table.scm")
(load-r "c02/p119-attach-tag.scm")

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2
                         (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                         (apply-generic op a1 (t2->t1 a2)))
                        (else
                         (error "No method for these types"
                                (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(load-r "c02/p129-install-scheme-number-package.scm")

(load-r "c02/p129-install-rational-package.scm")

(load-r "c02/p129-install-complex-package.scm")

;; 扩充到复数包
;; to be included in the complex package
;; (define (add-complex-to-schemenum z x)
;;   (make-from-real-imag (+ (real-part z) x)
;;                        (imag-part z)))
;; (put 'add '(complex scheme-number)
;;      (lambda (z x) (tag (add-complex-to-schemenum z x))))
;; 损害了以添加方式组合独立开发的程序包的能力.给独立程序包实现者增加了限制,要求对独立包工作时,必须同时注意其他包.
;; 处理复数和常规数的混合运算,看作复数包是合理的.但是关于有理数和复数的组合工作却存在许多选择,可以是有理数包也可以是复数包
;; 设计包含许多程序包和跨类型操作的系统时,想规划统一的策略,分清各种包之间的责任,很容易变成非常复杂的任务.

;; 强制过程
(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))
(put-coercion 'scheme-number 'complex scheme-number->complex)
