
(define (fast-prime? n times)
  (cond ((= times 0) true)
	((fast-test n) (fast-prime? n (- times 1)))
	(else false)))

(define (fast-test n)
  (define (try-it n a)
    (= (expmod a n n) a))
  (try-it n (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp) (remainder (square (expmod base (/ exp 2) m))
				m))
	(else (remainder (* base (expmod base (-1+ exp) m))
			 m))))

(expmod 2 3 3)

(fast-prime? 133 1)

