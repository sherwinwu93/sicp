(load-r "c02/ex2.81.scm")

;; 处理多个参数的一般性情况下的强制问题
;; 一种可能策略:将所有参数都强制到第一个参数类型,而后试着强制到第二个,并如此试下去
;; 给出一个例子说明还不够一般(像ex2.81的两个参数例子)
;; tips: 一些情况,表格里某些合用的操作不会被考虑

;; 答: 无法处理的情况: A`B`C三类型,A->B`B->C可以,但是却不能A->C

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

(define (try-coercoin-args args)
  (display args)
  (newline)
  (let ((arg1 (car args))
        (arg2 (cadr args)))

    (let ((type1 (type-tag arg1))
          (type2 (type-tag arg2)))

      (display type2)
      (display "-")
      (display type1)
      (let ((coercion-arg2 ((get-coercion type2 type1) arg2)))
        (if (= (length args) 2)
            (list arg1 coercion-arg2)
            (append (list arg1)
                    (try-coercoin-args (list (coercion-arg2)
                                             (cdr (cdr args)))))))))
  )
(try-coercoin-args (list (make-from-real-imag 3 4) (make-rational 1 3) (make-scheme-number 1)))

(define (apply-generic-list op args)
  (let ((type-tags (map type-tag args)))

        (let ((proc (get op type-tags)))

          (if proc
              (apply proc (map contents args))
              (let ((coercion-args (try-coercoin-args args)))

                (if coercion-args
                    (apply-generic-list op coercion-args)
                    (error "No method for these types" (list op args))))))))
