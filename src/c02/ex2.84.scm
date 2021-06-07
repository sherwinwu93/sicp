(load-r "c02/ex2.83.scm")
;; 利用raise修改apply-generic过程,能逐层提升参数强制到同样的类型
;;  要求: 与系统其他部分兼容,且不会影响塔中加入新层次

;; 逐层提升过程
(define (try-raise x y)
  (define (type-equals? x y)
    (equal? (type-tag x) (type-tag y)))
  (define (try-raise-temp x y)
    (if (type-equals? x y)
        (list x y)
        (let ((raise-x (get 'raise (list (type-tag x)))))

          (if raise-x
              (try-raise-temp (raise-x x) y)
              false))))
  (if (try-raise-temp x y)
      (try-raise-temp x y)
      (try-raise-temp y x)))
(try-raise (make-scheme-number 1) (make-rational 3 4))
(try-raise (make-from-real-imag 3 4) (make-scheme-number 1))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))

    (let ((proc (get op type-tags)))

      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((coercion-args (try-raise (car args) (cadr args))))
                (apply-generic op (car coercion-args) (cadr coercion-args)))
              ;; (let ((type1 (car type-tags))
              ;;       (type2 (cadr type-tags))
              ;;       (a1 (car args))
              ;;       (a2 (cadr args)))

              ;;   (let ((t1->t2 (get-coercion type1 type2))
              ;;         (t2->t1 (get-coercion type2 type1)))

              ;;     (cond (t1->t2
              ;;            (apply-generic op (t1->t2 a1) a2))
              ;;           (t2->t1
              ;;            (apply-generic op a1 (t2->t1 a2)))
              ;;           (else
              ;;            (error "No method for these types2"
              ;;                   (list op type-tags))))))
              (error "No methods for these types"
                     (list op type-tags)))))))
(apply-generic 'add (make-from-real-imag 3 4) (make-scheme-number 1))
