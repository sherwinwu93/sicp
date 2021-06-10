;; 环境模型的阶乘
(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))
;; (factorial 6)
;; 环境结构在面对循环时,比较繁琐
