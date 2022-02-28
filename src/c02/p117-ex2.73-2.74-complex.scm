;; ------------------------------------------------------------
;; 2.4 抽象数据的多重表示
;; 通过数据抽象屏障,大程序分割成小程序分别处理
;; 但还不够强大,基础表示不一定总有意义
;; eg. 复数:直角和极坐标.
;; 程序设计人多周期长,需求变化,导致数据表示的选择达成一致是不可能的
;; 问题解决: 除了表示与使用的抽象屏障,还有抽象屏障去隔离不同的设计选择. ->> 通用型过程
;; 通用性过程: 使用技术:类型标志, 程序设计:数据导向
;; 垂直屏障: 能隔离不同设计,并且安装其他的表示方式
;; ------------------------------------------------------------
;; 2.4.1 复数的表示
;; 四个选择函数:real-part`imag-part`magnitude`angle
;; 两个构造复数:make-from-real-imag`make-from-mag-ang
;;             (make-from-real-imag (real-part z) (imag-part z)) (make-from-mag-ang (magnitude z) (angle z))
(load-r "lib/put-get.scm")

;; 复数的算数
(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))))
(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
		       (- (imag-part z1) (imag-part z2))))
(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
		     (+ (angle z1) (angle z2))))
(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
		     (- (angle z1) (angle z2))))
;; 基于数值和表结构,实现构造和选择
;; Ben 直角坐标 x y
(define (real-part z) (car z))
(define (imag-part z) (cdr z))
(define (magnitude z)
  (sqrt (+ (square (real-part z)) (square (imag-part z)))))
(define (angle z)
  (atan (imag-part z) (real-part z)))
(define (make-from-real-imag x y)
  (cons x y))
(define (make-from-mag-ang r a)
  (cons (* r (cos a)) (* r (sin a))))
;; Alyssa 极坐标 r a
(define (real-part z)
  (* (magnitude z) (cos (angle z))))
(define (imag-part z)
  (* (magnitude z) (sin (angle z))))
(define (magnitude z) (car z))
(define (angle z) (cdr z))
(define (make-from-real-imag x y)
  (cons (sqrt (+ (square x) (square y)))
	(atan y x)))
(define (make-from-mag-ang r a) (cons r a))

;; 2.4.2 带标志数据
;; 数据抽象方式:最小允诺原则(将具体表示形式尽量往后推,保持系统的灵活性)
;; 即使同时使用Ben和Alyssa,仍然维持不确定性.需要找到对偶(3,4)的magnitude知道答案是3还是5
;; 解决方案: 类型标志
;; 类型标志的表示
(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))
(define datum1 (attach-tag 'tag 'contents))
(type-tag datum1)
(contents datum1)
(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))
(define (polar? z)
  (eq? (type-tag z) 'polar))
;; Ben 带类型标志
(define (real-part-rectangular z) (car z))
(define (imag-part-rectangular z) (cdr z))
(define (magnitude-rectangular z)
  (sqrt (+ (square (real-part-rectangular z))
	   (square (imag-part-rectangular z)))))
(define (angle-rectangular z)
  (atan (imag-part-rectangular z)
	(real-part-rectangular z)))
(define (make-from-real-imag-rectangular x y)
  (attach-tag 'rectangular (cons x y)))
(define (make-from-mag-ang-rectangular r a)
  (attach-tag 'rectangular
	      (cons (* r (cos a)) (* r (sin a)))))
;; Alyssa 带类型标志
(define (real-part-polar z)
  (* (magnitude-polar z) (cos (angle-polar z))))
(define (imag-part-polar z)
  (* (magnitude-polar z) (sin (angle-polar z))))
(define (magnitude-polar z) (car z))
(define (angle-polar z) (cdr z))
(define (make-from-real-imag-polar x y)
  (attach-tag 'polar
	      (cons (sqrt (+ (square x) (square y)))
		    (atan y x))))
(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar (cons r a)))
;; 通用性选择函数:检查参数的标志,调用适当过程
(define (real-part z)
  (cond ((rectangular? z)
	 (real-part-rectangular (contents z)))
	((polar? z)
	 (real-part-polar (contents z)))
	(else (error "Unknown type -- REAL-PART" z))))
(define (imag-part z)
  (cond ((rectangular? z)
	 (imag-part-rectangular (contents z)))
	((polar? z)
	 (imag-part-polar (contents z)))
	(else (error "Unknown type -- IMAG-PART" z))))
(define (magnitude z)
  (cond ((rectangular? z)
	 (magnitude-rectangular (contents z)))
	((polar? z)
	 (magnitude-polar (contents z)))
	(else (error "Unknown type -- IMAG-PART" z))))
(define (angle z)
  (cond ((rectangular? z)
	 (angle-rectangular (contents z)))
	((polar? z)
	 (angle-polar (contents z)))
	(else (error "Unknown type -- ANGLE" z))))
(define rec1 (make-from-real-imag-rectangular 3 4))
(real-part rec1)
(imag-part rec1)
(magnitude rec1)
(angle rec1)
(define polar1 (make-from-mag-ang-polar 5 .9272952180016122))
(real-part polar1)
(imag-part polar1)
(magnitude polar1)
(angle polar1)
;; 复数运算时不变
;; eg.add-complex不变
(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
		       (+ (imag-part z1) (imag-part z2))))
;; 最后的通用型构造
;;    合理选择: 有实部和虚部用直角坐标,有模和幅角用极座标
(define (make-from-real-imag x y)
  (make-from-real-imag-rectangular x y))
(define (make-from-mag-ang r a)
  (make-from-mag-ang-polar r a))
;; 重要的组织策略: 通用型选择剥去标志(基于类型的分派),构造时添加标志.
;; ------------------------------------------------------------
;; 2.4.3 数据导向的程序设计和可加性
;; 弱点: 1.通用型选择必须知道所有的表示
;;      2.不同表示的选择器不能重名               ---------> 不具备可加性
;; 解决方案: 数据导向的程序设计.能够直接利用这种表格工作的程序设计技术
;; api: (put <op> <type> <item>)
;;      (get <op> <type>) 找不到则返回假
;; Ben 完全按原来做的实现了代码
;;     完成了一个程序包
(define (install-rectangular-package)
  ;; internal procudures
  ;; 和原来一致,由于内部过程无需担心冲突
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
	     (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))

  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  ;; why is list?
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  ;; constructor use symbol not list
  (put 'make-from-real-imag 'rectangular
       (lambda(x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda(r a) (tag (make-from-mag-ang r a))))
  ;; installed
  'done)
(install-rectangular-package)
;; 通用操作!!!
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (error "No method for these types -- APPLY GENERIC"
		 (list op type-tags))))))
;; show起来
(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))
;; 利用数据导向程序设计技术,实现了可加性(新增新的表示,无需修改任何代码)
(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))

;; ------------------------------ 2.73
;; 2.3.2描述了执行符号求导的程序
(load-r "c02/p99-ex2.56-2.58-symbol-difference.scm")
(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp) (if (same-variable? exp var) 1 0))
	((sum? exp)
	 (make-sum (deriv (addend exp) var)
		   (deriv (augend exp) var)))
	((product? exp)
	 (make-sum
	  (make-product (multiplier exp)
			(deriv (multiplicand exp) var))
	  (make-product (deriv (multiplier exp) var)
			(multiplicand exp))))
	;; 更多规则添加在这里
	(else (error "unknown expression type -- DERIV" exp))))
;; 数据导向程序设计
(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp) (if (same-variable? exp var) 1 0))
	;; 根据符号找到具体的求导过程
	(else ((get 'deriv (operator exp)) (operands exp)
	       var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
;; a. 请解释上面究竟做了什么,为什么无法将谓词number?和same-variable?也加入到数据导向分派
;;    如果表达式是数字,那么导数是0;如果是变量,变量与var相同则1,否则0.
;;    如果是和式或加式等等...,根据对应符号找到对应求导过程,并用各项和var进行求导.
;;    number?和same-variable?不可以,因为数据抽象不一样
;; b. 写出和式和积式的求导过程,安装到表格里.
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (number? a1) (number? a2)) (+ a1 a2))
	(else (list '+ a1 a2))))

(define (install-deriv-sum-package)
  (define (deriv-operands operands var)
    (make-sum
     (deriv (car operands) var)
     (deriv (cadr operands) var)))
  ;; interface to rest system
  (put 'deriv '+ deriv-operands)
  "Done")
(install-deriv-sum-package)
(deriv (make-sum 'x 'y) 'x)
;; c. 选择新的球道规则包含进去
(define (make-product m1 m2)
  (cond ((=number? m1 0) 0)
	((=number? m2 0) 0)
	((=number? m1 1) m2)
	((=number? m2 1) m1)
	((and (number? m1) (number? m2)) (* m1 m2))
	(else (list '* m1 m2))))
(define (install-deriv-product-package)
  (put 'deriv '*
       (lambda(operands var) (let ((m1 (car operands))
				   (m2 (cadr operands)))
			       (display m1)
			       (newline)
			       (display m2)
			       (newline)
			       (make-sum
				(make-product m1
					      (deriv m2 var))
				(make-product (deriv m1 var)
					      m2)))))
  "Done")
(install-deriv-product-package)
(deriv (make-product 'x 'y) 'x)
