(load (absolute "c01/p34-prime-in-fermat-test.scm"))
;; 打印n,再检查是否素数,是素数打印检测时间
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (real-time-clock)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 1)
      (report-prime (- (real-time-clock) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(timed-prime-test 19999)

(load (absolute "c01/p34-prime-in-fermat-test.scm"))
;; 检查给定范围内连续的各个奇数的素性
(define (search-for-primes x)
  (cond ((even? x) (search-for-primes (+ x 1)))
        ((fast-prime? x 1) x)
        (else (search-for-primes (+ x 2)))))

;; 2
(timed-prime-test (search-for-primes 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000))

;; 5
(timed-prime-test (search-for-primes 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000))

;; 符合预期
