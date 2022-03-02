;; ------------------------------------------------------------
;; 2.5 带有通用型操作的系统
;; 将基本算术`有理数算术`复数算术都结合进来
;; ------------------------------------------------------------
;; 2.5.1 通用型算术运算
;; 通用型过程add: 常规的数->+,有理数->add-rat,复数->add-complex
(load-r "c02/generic-operator-system/attach-tag.scm")
(load-r "c02/generic-operator-system/apply-generic.scm")
(load-r "c02/generic-operator-system/ex2.82-apply-generic.scm")
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
(put 'add '(complex scheme-number) false)
;; 代价: 增加新类型时,需要修改其他类型实现跨类型操作.eg. 增加常规数类型,必须增加其他所有包的跨类型操作.损害了独立开发的可加性

;; 解决方案:强制
;; 不同的数据类型有些是相关的
(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))
;; 强制表格
(put-coercion 'scheme-number 'complex scheme-number->complex)
((get-coercion 'scheme-number 'complex) 10)
;; ------------------------------------------------------------
;; 类型的层次结构
;; 类型的层次结构:类型塔 整数->有理数->实数->复数 上父下子
;;    优点: 1.integer->complex, 不需要直接integer->complex, 而是integer->rational,rational->实数,实数->复数
;;         2.每个类型能够继承其超类型的所有操作
;;         3.有一种简单方法去下降数据对象
;; raise过程

;; ------------------------------------------------------------
;; 层次结构的不足
;; 现实中情况不是简单的塔形,一个类型有多个超类型.这时要找出正确超类型工作,可能涉及类型网络的大范围搜索
;;                                          同样下降也会遇到类似的情况


;; ------------------------------
;; ex2.81
;; Reasoner,两参数类型相同情况,apply-generic也可能做参数间的类型强制.
;;          强制表格中强制到自己的类型,
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(put-coercion 'scheme-number 'scheme-number
	      scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)
;; a.如果安装了Louis的强制过程,传参1和传参2都一样,表格又找不到相应操作
;; 答: no method for this type
(define (exp x y) (apply-generic 'exp x y))
(exp (make-complex-from-real-imag 3 4) (make-complex-from-real-imag 4 5))
(exp (make-scheme-number 3) (make-scheme-number 2))
;; b.Louis真的纠正了有关同样类型的强制问题吗?apply-generic像以前一样正常工作?
;; 没有纠正,像以前一样正常工作
;; c.修改apply-generic,使之不会强制两个同样类型的参数
;; 已修改
;; ------------------------------
;; ex2.82
;; 修改apply-generic,处理多个参数的一般性强制问题.
(define x (make-scheme-number 3))
(define z (make-complex-from-real-imag 3 4))
(add x z)
(add z x)
;; ------------------------------
;; ex2.83
(define (raise x)
  (let ((raise-1 (get-coercion 'raise (type-tag x))))
    (if raise-1
	(raise-1 x)
	false)))

(put-coercion 'raise 'scheme-number
	      (lambda(x)
		(make-rational x 1)))
(put-coercion 'raise 'rational
	      (lambda(x)
		(make-complex-from-real-imag x 0)))
(raise (raise (make-scheme-number 1)))
;; ------------------------------
;; ex2.84
;; 利用raise操作修改apply-generic过程,使之逐层提升到相同的类型
;; 需要安排一种方式,检查两个类型哪个更高.以一种可加性的方法
(add x z)
;; ex2.85
;; drop: 下落.下落到最后与原结果相等.
;; project: 投影.向下转型
(put-coercion 'project 'complex
	      (lambda (x)
		(real-part x)))
(put-coercion 'project 'rational
	      (lambda (x)
		(apply-generic 'numer x)))
(define (project x)
  (let ((op (get-coercion 'project (type-tag x))))
    (if op
	(op x)
	false)))
(define (drop x)
  (let ((lower-x (project x)))
    (if lower-x
	(if (equ? (raise lower-x) x)
	    (drop lower-x)
	    x)
	x)))
(drop (make-complex-from-real-imag (make-rational 2 1) 0))
;; ------------------------------
;; ex2.86 略
