(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fast-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (fast-test n)
  (define (try-it n a)
    (= (expmod a n n) a))
  (try-it n (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m))
                                m))
        (else (remainder (* base (expmod base (-1+ exp) m))
                         m))))

;; 错误的(expmod base exp m)
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

;; 代入分析下过程
(expmod 2 4 3)
(r (* (e 2 2 3) (e 2 2 3)) 3) ;; 2
(r (* (r (* (e 2 1 3) (e 2 1 3))) (* (e 2 1 3) (e 2 1 3))) 3);; 4
(r (* (r (* (r (* 2 (expmod 2 0 3))) (* (expmod 2 0 3) 2))) (r (* 2 (expmod 2 0 3)) (* 2 (expmod 2 0 3)))) 3);; 16
(r (* (r (* (r (* 2 1)) (* 1 2))) (r (* 2 1) (* 2 1))) 3);; 4
(r (* (r 2 3)) (r 2 3)) 3);;2
(r 2 3);;1
;; 原来的折半的每一步step上都运行翻倍的工作
;; 虽然步数减半,但是下一步相对上一步翻倍;所以时间复杂度是O(n)
