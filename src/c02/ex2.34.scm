(load "./p76-sum-odd-squares$even-fib.scm")

(define (horner-evel x coefficient-sequence)
  (accumulate (lambda(this-coeff higher-terms)
                (+ (* higher-terms x)
                   this-coeff))
              0
              coefficient-sequence))
(horner-evel 2 (list 1 3 0 5 0 1))
