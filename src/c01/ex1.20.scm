(define (gcd a b)
  (display "gcd\n")
  (if (= b 0)
      0
      (gcd b (remainder a b))))

;;执行了多少次
(gcd 206 40)
