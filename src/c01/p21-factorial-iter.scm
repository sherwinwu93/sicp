(define (factorial n)
  (factorial-iter 1 1 n)
)

(define (factorial-iter product counter max-count)
  (if (> counter max-count)
      product
      (factorial-iter (* product counter)
		 (1+ counter)
		 max-count)))

(factorial 4)

;; 优化成块结构
(define (factorial n)
  (define (factorial-iter product counter)
    (if (> counter n)
	product
	(factorial-iter (* product counter)
			(1+ counter))))

  (factorial-iter 1 1))


