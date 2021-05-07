(load (absolute "c02/p76-sum-odd-squares$even-fib.scm"))
(load (absolute "c01/p33-prime-in-smallest-divisor.scm"))

;; n为传参
(accumulate append
            ()
            (map (lambda(i)
                   (map (lambda(j) (list i j))
                        (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 10)))

(define (flatmap proc seq)
  (accumulate append () (map proc seq)))


;; 判断pair是否素数
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))
(cadr (list 1 2))
;; 生成结果的序列
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
;; prime-sum-pairs
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (lambda(i)
                  (map (lambda(j) (list i j))
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 6)))))
(prime-sum-pairs 6)
