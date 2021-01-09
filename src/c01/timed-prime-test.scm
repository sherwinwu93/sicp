(load "./smallest-divisor.scm")

(define (timed-prime-test n)
  (display n)
  (newline)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime)
                       start-time))))

(define (report-prime elapsed-time)
  (display "***")
  (newline)
  (display elapsed-time))

;; (timed-prime-test 199999)
