;; apply-generic 根据对象执行操作
(define (apply-generic op . args)
  (display "APPLY-GENERIC")
  (display (list op args))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for these types -- APPLY-GENERIC"
           (list op type-tags))))))
