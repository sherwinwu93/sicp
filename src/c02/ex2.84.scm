(load-r "c02/ex2.83.scm")

;; 利用ex2.83的raise操作修改apply-generic过程,
;; 修改后,能逐层提升将参数强制到同样的类型.即--检查两个类型哪个更高
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))

    (let ((proc (get op type-tags)))

      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((t-lst (raise-2 (car args) (cadr args))))

                (display (car t-lst))
                (newline)
                (display (cadr t-lst))
                (apply-generic op (car t-lst) (cadr t-lst)))
              (error "No methods for these types"
                     (list op type-tags)))))))
(define (raise-2 x y)
  (define (temp t1 t2)
    (let ((type1 (type-tag t1))
          (type2 (type-tag t2)))

      (if (equal? type1 type2)
          (list t1 t2)
          (let ((raise1 (get-coercion 'raise type1)))
            (if raise1
                (temp (raise1 t1) t2)
                false)))))
  (let ((res (temp x y)))
    (if res
        res
        (temp y x))))
(raise-2 (make-scheme-number 1) (make-rational 1 2))
(apply-generic 'add (make-scheme-number 1) (make-rational 1 2))
(add (make-rational 1 1) (make-rational 1 2))
