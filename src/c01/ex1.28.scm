;; (define (fast-prime? n times)
;;   (cond ((= times 0) true)
;;         ((fast-test n) (fast-prime? n (- times 1)))
;;         (else false)))

;; (define (fast-test n)
;;   (define (try-it n a)
;;     (= (expmod a n n) a))
;;   (try-it n (+ 1 (random (- n 1)))))

;; miller-rabin检查: 来源于费马小定理的变形,但是不会像费马检查被欺骗
;;                   n是素数,a<n(整数),那么a^(n-1)与1模n同余
;; 1取模n的非平凡平方根: 不等于1
;;                       不等于n
;;                       a的平方取模n=1
;; 如果非平方平方根存在,就不是素数
;; n是非素数的奇数,至少一半的a<n,按这种方式计算a^(n-1),会遇到非平凡平方根
;; 1/2筛选掉一半,再进行miller-rabin检查

;; 增加存在非平凡平方根return 0
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((nontrivial-square-root? base m) 0)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

;; 非平方根,a != 1, a != n-1, a^2 mod n = 1
(define (nontrivial-square-root? a n)
  (and (not (= a 1))
       (not (= a (- n 1)))
       (= 1 (remainder (square a) n))))

;; 不为0的随机数从0到n
(define (non-zero-random n)
  (let ((r (random n)))
    (if (not (= r 0))
        r
        (non-zero-random n))))

;; 向上取整n/2次,测试, 因为miller-rabin也是概率函数
(define (Miller-Rabin-test n)
  (let ((times (ceiling (/ n 2))))
    (test-iter n times)))

;; 测试-iter, 经过times次后,认为其是素数
(define (test-iter n times)
  (cond ((= times 0) #t)
        ((= (expmod (non-zero-random n) (- n 1) n) 1)
         (test-iter n (- times 1)))
        (else #f)))

;; carmichael
(miller-rabin-test 561)
(miller-rabin-test 1105)
(miller-rabin-test 1729)
(miller-rabin-test 2465)
(miller-rabin-test 2821)
(miller-rabin-test 6601)

;; 真正的素数
(miller-rabin-test 7)
(miller-rabin-test 17)
(miller-rabin-test 19)

(define (miller-rabin-test n)
  (let ((times (ceiling (/ n 2))))
    (test-iter n times)))

(define (test-iter n times)
  (cond ((= times 0) #t)
        ((= (expmod (non-zero-random n) (- n 1) n) 1)
         (test-iter n (- times 1)))
        (else #f)))

(define (non-zero-random n)
  (let ((r (random n)))
    (if (= r 0)
        (non-zero-random n)
        r)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((nontrivial-square-root? base m)
         0)
        ((even? exp)
         (remainder (square
                     (expmod base (/ exp 2) m))
                    m))
        (else (remainder
               (* base
                  (expmod base (- exp 1) m))
               m))))

(define (nontrivial-square-root? a n)
  (and (not (= a 1))
       (not (= a n))
       (= 1 (remainder (square a) n))))
