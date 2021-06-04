(define (apply-generic op . args)
  (display 1)
  (let ((type-tags (map type-tag args)))

    (display 2)
    (let ((proc (get op type-tags)))

      (display 3)
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))

                (display 4)
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))

                  (display 5)
                  (cond (t1->t2
                         (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                         (apply-generic op a1 (t2->t1 a2)))
                        (else
                         (error "No method for these types2"
                                (list op type-tags))))))
              (error "No methods for these types"
                     (list op type-tags)))))))
