;; a. product的过程,计算给定范围个点的函数值的乘积.
;;    用product定义factorial,计算pi的近似值
;; 递归版本
(define (product term a next b)
  (if (> a b)
      1.0
      (* (term a)
         (product term (next a) next b))))
;; 1*2*3=6
(product (lambda(x) x) 1 1+ 3)

(define (factorial a b)
  (define (f-term k)
    (if (even? k)
        (/ (+ k 2)
           (+ k 3))
        (/ (+ k 3)
           (+ k 2))))
  (product f-term a 1+ b))

(* 4 (factorial 0 10000))
;; b.product迭代版本
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))
;; 1*2*3=6
(product (lambda(x) x) 1 1+ 3)

