;; accumulate过程，一般性的累积函数组合起一系列项
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner
                            null-value
                            term
                            (next a)
                            next
                            b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(sum (lambda(a) a) 1 1+ 3)

(define (product term a next b)
  (accumulate * 1 term a next b))

(product (lambda (a) a) 1 1+ 4)

;; 迭代版本
(define (accumulate combiner null-value term a next b)
  (define (iter curr result)
    (if (> curr b)
        result
        (iter (next curr)
              (combiner result (term curr)))))
  (iter a null-value))
