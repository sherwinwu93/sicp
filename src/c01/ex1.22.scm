(real-time-clock)

;; 打印n,再检查是否素数,是素数打印检测时间
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (real-time-clock)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (real-time-clock) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(timed-prime-test 19999)

(load "p33-prime-in-smallest-divisor")
;; 检查给定范围内连续的各个奇数的素性
(define (search-for-primes x)
  (cond ((even? x) (search-for-primes (+ x 1)))
        ((prime? x) x)
        (else (search-for-primes (+ x 2)))))
;; 大于1000的最小素数需要的时间 1
(timed-prime-test (search-for-primes 1000000))
;; 10 000 3 3.16倍
(timed-prime-test (search-for-primes 10000000))
;; 100 000 8
(timed-prime-test (search-for-primes 100000000))
;; 1000 000 24 8的3.16倍
(timed-prime-test (search-for-primes 1000000000))

;; 得到的结果符合这种说法
