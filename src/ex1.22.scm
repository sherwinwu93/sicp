(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(timed-prime-test 99999959)

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime)
		       start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes min)
  (search-for-prime-odd (if (even? min)
			    (+ min 1)
			    min)))

(define (search-for-prime-odd odd)
  (if (prime? odd)
      (timed-prime-test odd)
      (search-for-prime-odd (+ odd 2))))

(search-for-primes 10000000000000)
(search-for-primes 1000000000000000)
(search-for-primes 100000000000000000)
(search-for-primes 10000000000000000000)









