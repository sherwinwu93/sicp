;; a. 无穷连分式: f= N1/(D1 + N2)
;;    写出过程(cont-frac n d k)计算出k项有限连分式
(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (if (= i k)
            (iter (- i 1) result)
            (iter (- i 1) (/ (n i)
                              (+ (d i) result))))))
  (iter k (/ (n k) (d k))))
;;    使用该过程检验顺序k值是否逼近1/黄金分割率
;; 经实验确实是
(cont-frac (lambda(i) 1.0)
           (lambda(i) 1.0)
           1000)

;; 递归计算过程
(define (cont-frac n d k)
  (define (recur n d i k)
    (if (= i k)
        (/ (n k) (d k))
        (/ (n k)
           (+ (d k)
              (recur n d (+ i 1) k)))))
  (recur n d 1 k))
