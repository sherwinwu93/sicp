;; 表达式是和式`乘式`常量或者是变量;
;; 也能提取表达式的各个部分
;; 还能用几个部分构造整个表达式

;; 数据抽象
;; e是变量吗?
(variable? e)
;; v1和v2是同一个变量吗?
(same-variable? v1 v2)
;; e是和式吗?
(sum? e)
;; e的被加数
(addend e)
;; e的加数
(augend e)
;; 构造a1和a2的和式
(make-sum a1 a2)

;; e是乘式吗
(product? e)
;; e的被乘法
(multiplier e)
;; e的乘数
(multiplicand e)
;; 构造m1与m2的乘式
(make-product m1 m2)

;; 基本过程number?
;; 符合求导,只要选择函数和构造函数正确,整个过程都可以工作
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

;; 代数表达式的表示:ax+b表示为(+ (* a x) b)(比 (a * x + b) 更直接了当)
;; 由此求导问题的数据表示是
;; - 变量就是符号,基本过程symbol?
(define (variable? x) (symbol? x))
;; - 两个变量相同就是表示符号相互eq?
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
;; - 和式与乘式都构造为表
(define (make-sum a1 a2) (list '+ a1 a2))
(define (make-product m1 m2) (list '* m1 m2))
;; 和式就是第一个元素为符号+的表
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
;; 被加数是表示和式的表里的第二个元素
(define (addend s) (cadr s))
;; 加数是表示和式的表里的第三个元素
(define (augend s) (caddr s))
;; 乘式是第一个元素为符号*的表
(define (product? x) (eq? (car x) '*))
;; 被乘数是表示乘式的表的第二个元素
(define (multiplier p) (cadr p))
;; 乘数是表示乘式的表的第三个元素
(define (multiplicand p) (caddr p))

;; test符号求导
;; (+ 1 0)
;; 1
(deriv '(+ x 3) 'x)
;; (+ (* x 0) (* 1 y))
;; y
(deriv '(* x y) 'x)
;; (+ (* (* x y) (+ 1 0)) (* (+ (* x 0) (* 1 y)) (+ x 3)))
;; (+ (* x y) (* y (+ x 3)))
(deriv '(* (* x y) (+ x 3)) 'x)

;; 结果化为最简单形式
;; make-sum优化
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
;; =number?过程:检查某个表达式是否等于某个值
(define (=number? exp num)
  (and (number? exp) (= exp num)))
;; make-product优化
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
;; 第三个列子: (+ (* x y) (* y (+ x 3))),做成"最简式",还有很多路要走
;;                                       某种用途的最简形式,对于另外一种用途可能不是最简形式
