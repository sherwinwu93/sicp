;; filter:过滤器概念,比accumulate更一般
;;        只组合给定范围项里满足特定条件的项
;;        与accumulate累积过程相比多加过滤器参数

;; 写出filtered-accumulate过程
(define (filtered-accumulate filter combiner null-value term a next b)
  (cond ((> a b) null-value)
        ((not (filter a))
         (filtered-accumulate filter
                              combiner
                              null-value
                              term
                              (next a)
                              next
                              b))
        (else
         (combiner (term a)
                   (filtered-accumulate filter
                                        combiner
                                        null-value
                                        term
                                        (next a)
                                        next
                                        b)))))
(load "p33-prime-in-smallest-divisor.scm")

(define (sum-prime a b)
  (define (identity x) x)
  (filtered-accumulate prime?
                       +
                       0
                       identity
                       (+ a 1)
                       1+
                       b))
2 3 5 7
(sum-prime 1 10)

(gcd 2 3)
(define (product-relatively-prime a b)
  (define (identity x) x)
  (define (relatively-prime x)
    (and (< x b)
         (= (gcd x b) 1)))
  (filtered-accumulate relatively-prime
                       *
                       1
                       identity
                       a
                       1+
                       b))

(product-relatively-prime 2 3)
