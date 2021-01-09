(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime)
                       start-time))))
(define (report-prime elapsed-time)
  (display "***")
  (display elapsed-time))
(define (search-for-primes min)
  (search-for-primes-odd (if (even? min)
                             (+ min 1)
                             min)))
(define (search-for-primes-odd odd)
  (if (prime? odd)
      (timed-prime-test odd)
      (search-for-prime-odd (+ odd 2))))

