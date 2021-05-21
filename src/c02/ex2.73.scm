(load-r "c02/p99.scm")
(load-r "c02/p186-make-table.scm")
;; 执行符号求导的程序
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
        (else (error "unknown expression type -- DERIV" exp))))

(deriv '(* (+ 3 x) 4) 'x)
;; 可以认为,程序是执行基于求导表达式类型的分派工作.这里,数据的类型标志就是代数运算符,需要执行的操作是deriv.
;; 变换为数据导向的风格
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else
         (display (get 'deriv (operator exp)))
         ((get 'deriv (operator exp))
               (operands exp)
               var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
;; a.上面究竟做了什么?为什么无法将number?和same-variable?也加入数据导向分派中?
;; 答:数据导向的deriv.当exp是number时,0;当exp是变量时,exp与var相同时是1,不同时是0;其他情况,根据exp的operator获取响应的导数,并作用于exp的运算部分与var
;;    因为number和same-variable时,exp没有operands

;; b.写出针对和式与积式的求导过程,并安装到表格里,能运行deriv
(define (install-deriv-package)
  (define (sum-deriv operands var)
    (let ((exp (cons '+ operands)))
      (make-sum (deriv (addend exp) var)
                (deriv (augend exp) var))))
  (define (product-deriv operands var)
    (let ((exp (cons '* operands)))
      (make-sum
       (make-product (multiplier exp)
                     (deriv (multiplicand exp) var))
       (make-product (deriv (multiplier exp) var)
                     (multiplicand exp)))))
  (put 'deriv '* product-deriv)
  (put 'deriv '+ sum-deriv)
  'Done)
(install-deriv-package)
(deriv '(* (+ 3 x) 4) 'x)

;; c.添加乘幂求导
(load-r "c02/ex2.56.scm")
(define (install-exponentiation-deriv-package)
  (define (exponentiation-deriv operands var)
    (let ((exp (cons '** operands)))
      (make-product (exponent exp)
                    (make-product (make-exponentiation (base exp)
                                                       (make-sum (exponent exp)
                                                                 -1))
                                  (deriv (base exp) var)))))
  (put 'deriv '** exponentiation-deriv)
  'Done)
(install-exponentiation-deriv-package)
(deriv '(** x 3) 'x)
;; d.完成分派的代码进行修改 ((get (operator exp) 'deriv) (operands exp) var)
;; 答:install的时候对应跟着修改即可
