(load "./smallest-divisor.scm")
(load "./timed-prime-test.scm")

(define (next test-divisor)
  (if (= test-divisor 2)
      3
      (+ test-divisor 2)))

;; find-divisor代替之前的find-divisior
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divide? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(timed-prime-test 19999999)
