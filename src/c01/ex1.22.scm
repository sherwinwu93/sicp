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

(load (absolute "p33-prime-in-smallest-divisor")
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

;; 问题拆解
;; 1. 产生下个奇数的过程
;; 2. 检查素数的过程
;; 3. 给定n和count,生成count个大于n的素数
;; 4. 测量寻找素数的时间

;; 下个奇数
(define (next-odd n)
  (if (odd? n)
      (+ n 2)
      (+ n 1)))
(next-odd 3)
(next-odd 4)

;; 检查素数的函数
(load (absolute "c01/p33-prime-in-smallest-divisor.scm"))
(prime? 2)
(prime? 3)

;; 生成count个大于n的素数
(define (search-for-primes x count)
  (cond ((= count 0)
         (newline)
         (display "done"))
        ((prime? x)
         (newline)
         (display x)
         (search-for-primes (next-odd x) (- count 1)))
        (else (search-for-primes (next-odd x) count))))

(search-for-primes 1000 10)

;; 运行时间
(define (test-foo n)
  (let ((start-time (real-time-clock)))
    (search-for-primes n 1000)
    (- (real-time-clock) start-time)))
;; 166 1.5
;; (test-foo 1000)
;; 250 2.4
;; (test-foo 10000)
;; 600 2.4
;; (test-foo 100000)
;; 1600 2.666倍
;; (test-foo 1000000)
;; 5000 3.125倍
;; (test-foo 10000000)

;; 问题规模越大,越接近理论值

