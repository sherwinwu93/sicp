;; 正切函数的连分式
;; 写出过程(tan-cf x k)
(define (tan-cf x k)
  (define (n counter)
    (if (= counter 1)
        x
        (square x)))
  (define (d counter)
    (- (* 2 counter)
       1))
  (define (recur counter)
    (if (= counter k)
        (/ (n counter) (d counter))
        (/ (n counter)
           (- (d counter)
              (recur (+ counter 1))))))
  (recur 1))

(exact->inexact (tan-cf 1 10))
