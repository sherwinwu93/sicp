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
;; 正常情况,路径也是折半,并且由于square没有重复计算两次,而且remainder循环往复,计算过程的传参始终很低
(expmod 2 8 3)
(remainder (square (expmod 2 4 3)) 3)
(remainder (square (remainder (square (expmod 2 2 3)) 3)) 3)
(remainder (square (remainder (square (remainder (square (expmod 2 1 3)) 2)) 3)) 3)
(remainder (square (remainder (square (remainder (square (* 2 (expmod 2 0 3))) 2)) 3)) 3)
(remainder (square (remainder (square (remainder (square (* 2 1)) 3)) 3)) 3)
(remainder (square (remainder (square (remainder (square 2) 3)) 3)) 3)
(remainder (square (remainder (square (remainder 4 3)) 3)) 3)
(remainder (square (remainder (square 1) 3)) 3)
(remainder (square (remainder 1 3)) 3)
(remainder (square 1) 3)
(remainder 1 3)
1

;; 对(expmod base exp m)的修改
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))
(load "p30-fast-expt.scm")
(expmod 2 8 3)
(remainder (fast-expt 2 8) 3)
(remainder 256 3)
1
;; 其中fast-expt, 注意路径是折半的
(fast-expt 2 8)
(* (fast-expt 2 4) (fast-expt 2 4))
(* (* (fast-expt 2 2) (fast-expt 2 2)) (* (fast-expt 2 2) (fast-expt 2 2)))
(* (* (* (fast-expt 2 1) (fast-expt 2 1)) (* (fast-expt 2 1) (fast-expt 2 1))) (* (* (fast-expt 2 1) (fast-expt 2 1)) (* (fast-expt 2 1) (fast-expt 2 1))))
(* (* (* 2 2) (* 2 2)) (* (* 2 2) (* 2 2)))
(* (* 4 4) (* 4 4))
(* 16 16)
256
;; 所以原来的方案优于现在的方案
