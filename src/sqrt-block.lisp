(DEFINE SQRT (lambda (x)

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

(DEFINE (IMPROVE GUESS X)
	(AVERAGE GUESS
			(/ X GUESS)))

(DEFINE AVERAGE (lambda (x y)
	(/ (+ x y) 2)))

(DEFINE (ABS X)
        (COND ((< X 0) (- X))
                  ((= X 0) 0)
                  ((> X 0) X)))

    (TRY 1.0 x)))

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

(DEFINE (ABS X)
        (COND ((< X 0) (- X))
                  ((= X 0) 0)
                  ((> X 0) X))))

(DEFINE AVERAGE (lambda (x y)
	(/ (+ x y) 2)))

(sqrt 4.0)
