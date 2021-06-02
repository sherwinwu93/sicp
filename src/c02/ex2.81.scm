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
                         (error "No method for these types2"
                                (list op type-tags))))))
              (error "No method for these type1"
                     (list op type-tags)))))))

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(load-r "c02/p129-install-scheme-number-package.scm")
(load-r "c02/p129-install-rational-package.scm")
(load-r "c02/p129-install-complex-package.scm")

;; a. 1.安装了Louis的强制过程
;;    2.调用apply-generic时,各传参类型为同类型
;;    3.表格中找不到相应操作
;;    会出现什么情况

;; 没有使用Louis的强制过程
(define (exp x y) (apply-generic 'exp x y))
;; scheme-number放入求幂过程,其他不放
(put 'exp '(scheme-number scheme-number)
     (lambda (x y) (tag (exp x y)))) ; using primitive expt
;; 求值exp 两个复数
;; 正常报错
(exp (make-from-real-imag 3 4) (make-from-real-imag 3 4))

;; 使用Louis的强制过程
(define (complex->complex z) z)
(put-coercion 'complex 'complex complex->complex)
;; 求值exp 两个复数
;; 无限递归
(trace apply-generic)
(exp (make-from-real-imag 3 4) (make-from-real-imag 3 4))

;; b. Louis 真的就纠正了同类型参数的强制问题吗?
没有,无限循环递归,甚至更糟了
;; c. 修改apply-generic
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags)))
                (if (equal? type1 type2)
                    (error "no method for these type3")
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
                               (error "No method for these types2"
                                      (list op type-tags))))))))
              (error "No method for these type1"
                     (list op type-tags)))))))
(exp (make-from-real-imag 3 4) (make-from-real-imag 3 4))
