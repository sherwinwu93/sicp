;; 素数: 其最小因子(除1外)是不是其自身.是则素数.不是则非素数
(load-r "lib/math.scm")
(define (smallest-divisor n)
  (find-divisor  n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n
			    (+ test-divisor 1)))))
(define (prime? n)
  (= n (smallest-divisor n)))
(prime? 2)
(prime? 3)
(prime? 4)
(prime? 1999999999999999998)
