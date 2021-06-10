;; 迭代式求阶乘程序
;; 函数式程序设计
(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))
;; 命令式程序设计
(define (factorial n)
  (let ((product 1)
        (counter 1))

    (define (iter)
      (if (> counter n)
          product
          ;; (begin (set! product (* counter product))
          ;;        (set! counter (+ counter 1))
          ;;        (iter))))
          ;; 由此会产生错误
          (begin (set! counter (+ counter 1))
                 (set! product (* counter product))
                 (iter))))
    (iter)))
