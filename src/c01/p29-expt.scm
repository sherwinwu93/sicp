;; 线性递归
(define (expt b n)
  (if (= n 0)
      1
      (* b (expt b (- n 1)))))
;; 迭代
(define (expt b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
		 (- counter 1)
		 (* b product))))

(expt 2 10)
