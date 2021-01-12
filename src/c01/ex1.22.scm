(load "./timed-prime-test.scm")
(timed-prime-test 10000000000)

(define (search-for-primes min)
  (search-for-primes-odd (if (even? min)
                         (+ min 1)
                         min)))

(define (search-for-primes-odd odd)
  (if (prime? odd)
      (timed-prime-test odd)
      (search-for-primes-odd (+ odd 2))))

;; 根号n倍
(search-for-primes 10000000000)
(search-for-primes 1000000000000)
