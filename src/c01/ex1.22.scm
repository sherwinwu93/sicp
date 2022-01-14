;; process-time-clock
;; ex1.22.scm
(runtime)
(process-time-clock)
(load-r "c01/p33-smallest-divisor")
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (process-time-clock)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-time (- (process-time-clock) start-time))))
(define (report-time elapsed-time)
  (display "***")
  (display elapsed-time))
(timed-prime-test 1999999999999999998)

(define (search-for-primes start n)
  (if (even? start)
      (search-for-primes-iter (+ start 1) n)))
(define (search-for-primes-iter odd n)
  (cond ((= n 0) (display "Done"))
	((prime? odd)
	 (timed-prime-test odd)
	 (search-for-primes-iter (+ odd 2)
				 (- n 1)))
	(else
	 (search-for-primes-iter (+ odd 2)
				 n))))
;;(search-for-primes 1000000000 3)
;; (search-for-primes 10000000000 3)
;; (search-for-primes 100000000000 3)
;; O(n) = (sqrt n) 差不多

