;; 素数: 其最小因子(除1外)是不是其自身.是则素数.不是则非素数
(load-r "lib/math.scm")
(load-r "c01/ex1.22.scm")
(define (smallest-divisor n)
  (find-divisor  n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n
			    (next test-divisor)))))
(define (next a)
  (if (= a 2)
      3
      (+ a 2)))
(define (prime? n)
  (= n (smallest-divisor n)))
(search-for-primes 1000000000 3)
(search-for-primes 10000000000 3)
(search-for-primes 100000000000 3)
;; 大概是2/3的比值,因为虽然remainder次数减少了,但是还需要=次数多了

