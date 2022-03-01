;; ------------------------------------------------------------
;; 2.5 带有通用型操作的系统
;; 将基本算术`有理数算术`复数算术都结合进来
;; ------------------------------------------------------------
;; 2.5.1 通用型算术运算
;; 通用型过程add: 常规的数->+,有理数->add-rat,复数->add-complex
(load-r "c02/generic-operator-system/attach-tag.scm")
(load-r "c02/generic-operator-system/apply-generic.scm")
(load-r "lib/put-get.scm")
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
;; 常规的数
(load-r "c02/generic-operator-system/install-scheme-number-package.scm")
(install-scheme-number-package)
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))
(add (make-scheme-number 3) (make-scheme-number 4))
;; 有理数算术程序包
;; 二级
(load-r "c02/generic-operator-system/install-rational-package.scm")
(install-rational-package)
(define (make-rational n d)
  ((get 'make 'rational) n d))
(define x1 (make-rational 1 2))
(define x2 (make-rational 2 3))
(add x1 x2)
;; complex
(load-r "c02/generic-operator-system/install-rectangular-package.scm")
(install-rectangular-package)
(load-r "c02/generic-operator-system/install-polar-package.scm")
(install-polar-package)
(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(load-r "c02/generic-operator-system/install-complex-package.scm")
(install-complex-package)
(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))
(add (make-complex-from-real-imag 3 4) (make-complex-from-real-imag 4 5))

;; ------------------------------
;; ex2.77为啥complex包加入这些东西就可以
;; 如果不加,表格里面并没有'magnitude '(complex)
;; 有了以后: 'magnitude '(complex) tag-complex
;;          'magnitude '(rectangular) tag-rectangular
;;          (sqrt (+ (square 3) (square 4)))
(define z (make-complex-from-real-imag 3 4))
(define z2 (make-complex-from-real-imag 0 4))
(magnitude z)
(apply-generic 'magnitude '(complex rectangular 3 . 4))
((get 'magnitude '(complex)) '(rectangular 3 . 4))
(magnitude '(rectangular 3 . 4))
((get 'magnitude '(rectangular)) '(3 . 4))
(sqrt (+ (square 3)
	 (square 4)))
;; ex2.79equ?, 检查两个数是否相等
(load-r "c02/generic-operator-system/equ.scm")
;; ex2.80 =zero?
(define (=zero? x)
  (apply-generic '=zero? x))

;; ------------------------------------------------------------
;; 2.5.2 不同类型数据的组合
;; 在程序的各个部分之间引进了屏障,现在让我们引入跨类型的操作

;; 用于复数+常规数 (跨类型操作)
(define (add-complex-to-schemenum z x)
  (make-from-real-imag (+ (real-part z) x)
		       (imag-part z)))
(put 'add '(complex scheme-number)
     (lambda (z x) (tag (add-complex-to-schemenum z x))))
;; 代价: 增加新类型时,需要修改其他类型实现跨类型操作.eg. 增加常规数类型,必须增加其他所有包的跨类型操作.损害了独立开发的可加性

;; 解决方案:强制
;; 不同的数据类型有些是相关的
(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))
;; 强制表格
(put 'scheme-number 'complex scheme-number->complex)
