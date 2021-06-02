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
              (error "No method for these types2"
                     (list op type-tags)))))))
;; 安装常规数包到通用
(load-r "c02/p129-install-complex-package.scm")
(load-r "c02/p129-install-scheme-number-package.scm")
(load-r "c02/p129-install-rational-package.scm")

;; 推广apply-generic,处理多个参数的一般性情况下
(define (apply-generic2 op args)
  (display (list op args))
  (newline)
  (let ((first-arg (car args)))

    (let ((first-type (type-tag first-arg)))

      (let ((same-type-args (map (lambda (arg)
                                   (display "first-type")
                                   (newline)
                                   (display first-type)
                                   (newline)
                                   (display (type-tag arg))
                                   (newline)
                                   (if (equal? first-type (type-tag arg))
                                       arg
                                       (let ((force (get-coercion (type-tag arg) first-type)))

                                         (if force
                                             (force arg)
                                             (error "force error")))))
                                 args)))

        (if (= (length same-type-args) 2)
            (let ((proc (get op (list first-type first-type))))

              (if proc
                  (apply proc (map contents same-type-args))
                  (error "No these methods3")))
            (apply-generic2 op
                            (append (apply-generic2 op
                                                  (list (car same-type-args)
                                                        (cadr same-type-args)))
                                    (cdr (cdr same-type-args)))))))))

(put-coercion 'scheme-number 'complex
              (lambda (x)
                (make-from-real-imag (contents x) 0)))

(apply-generic2 'add (list (make-from-real-imag 3 4) (make-scheme-number 1) (make-scheme-number 2)))
