;; accumulate累积: 是sum和product的更一般的概念
;; 1. 写出accumulate过程
;; 2. 用accumulate过程定义sum`product
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate
                 combiner
                 null-value
                 term
                 (next a)
                 next b))))

;; 用accumulate定义sum
(define (sum term a next b)
  (accumulate + 0 term a next b))
;; 1+4+9=14
(sum (lambda(x) (square x)) 1 1+ 3)

;; 用accumulate定义product
(define (product term a next b)
  (accumulate * 1 term a next b))
;; 1*4*9=36
(product (lambda(x) (square x)) 1 1+ 3)


;; 写出accumulate过程的迭代版本
(define (accumulate combiner null-value term a next b)
  (define (iter curr result)
    (if (> curr b)
        result
        (iter (next curr) (combiner result (term curr)))))
  (iter a null-value))
