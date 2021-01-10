(load "./timed-prime-test.scm")
(load "./fermat-test.scm")

(define (start-prime-test n start-time)
  (if (fast-prime? n 1000)
      (report-prime (- (runtime)
                       start-time))))

(timed-prime-test 10000000000)
