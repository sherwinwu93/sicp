(load "./ex1.21-smallest-divisor.scm")

(define (next test-divisor)
  (if (= test-divisor 2)
      3
      (+ test-divisor 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((devide? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(smallest-divisor 19999)
