# 亚历山大平方根
(DEFINE SQRT (lambda (x) (TRY 1.0 x)))

(DEFINE TRY (lambda (GUESS X)
				(IF (GOOD-ENOUGHT? GUESS X)
					GUESS
					(TRY (IMPROVE GUESS X)
						  X))))

(DEFINE (GOOD-ENOUGHT? GUESS X)
	(IF (< (ABS
			(- (SQUARE GUESS)
				(SQUARE
					(AVERAGE GUESS
							(/ X GUESS)))))
            0.01)
		true
		false))
(good-enought? 3.0 4.0)


(DEFINE (IMPROVE GUESS X)
	(AVERAGE GUESS
			(/ X GUESS)))

(DEFINE (ABS x)
				(COND ((< x 0) (- x))
					  ((= x 0) 0)
					  ((> x 0) x))))

(DEFINE AVERAGE (lambda (x y)
	(/ (+ x y) 2)))

