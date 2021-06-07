(load-r "c02/ex2.84.scm")
;; "简化"数据对象表示的一种方法,使之尽可能下降
;; 过程drop完成上述工作
;;   关键:一般性方式,判断数据能否下降.例如:复数3/2+0i下降到real,1+0i下降到scheme-number,3+2i无法下降
;;     能否下降:先下降,再raise判断其是否相同

;; 计划:
;;   1. 定义project(投影).例如:a+bi->a;并且使用相等谓词project?
;;   2. 安装project,project?
;;   3. 写出过程drop,使对象尽可能地下落
;;   4. 重写apply-generic,使之可以简化结果

(define (install-rational-project-package)
  (define (project x)
    (let ((unpack-x (contents x)))
      (make-scheme-number (numer unpack-x))))
  (define (project? x)
    (let ((project-x (project x)))

      (let ((type-tag-px (type-tag project-x)))

        (equ? x ((get 'raise (list type-tag-px)) project-x)))))
  (put 'project '(rational) project)
  (put 'project? '(rational) project?)
  )
(define rational-rational-package (install-rational-project-package))
((get 'project? '(rational)) (make-rational 3 2))
(define (install-complex-project-package)
  (define (project x)
    (let ((unpack-x (contents x)))
      (real-part x)))
  (define (project? x)
    (let ((project-x (project x)))

      (let ((type-tag-px (type-tag project-x)))

        (equ? x ((get 'raise (list type-tag-px)) project-x)))))
  (put 'project '(complex) project)
  (put 'project? '(complex) project?)
  )
(define complex-project-package (install-complex-project-package))
((get 'project? '(complex)) (make-from-real-imag (make-rational 3 4) 4))

(define (drop obj)
  (display obj)
  (newline)
  (let ((type-tags (list (type-tag obj))))
    (display type-tags)
    (newline)
    (let ((project? (get 'project? type-tags))
          (project (get 'project type-tags)))
      (if project?
          (if (not (project? obj))
              obj
              (drop (project obj)))
          obj))))
(define c1 (make-from-real-imag (make-rational 3 1) 0))
(drop c1)
((get 'project? '(rational)) (make-rational 3 1))

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
              (error "No methods for these types"
                     (list op type-tags)))))))
