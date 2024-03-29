(define (compare-string x y)
  (cond ((string=? x y)
	 0)
	((string>? x y)
	 1)
	((string<? x y)
	 -1)))
(define (compare-symbol x y)
  (compare-string (symbol->string x)
		  (symbol->string y)))
(define (compare-number x y)
  (cond ((= x y) 0)
	((> x y) 1)
	((< x y) -1)))
