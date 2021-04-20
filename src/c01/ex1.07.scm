(load "p16-sqrt.scm")
(load "p15-improve.scm")
(load "p15-average.scm")
(load "p15-sqrt-iter.scm")
(load "p15-good-enough.scm")
;; 正确值是0.0094868329805051, 得到的是0.03134... 差距过大
(sqrt 0.000009)
;; 过大由于精度不够
(sqrt 900000000000000000000000000000000000000000000000000000000000000000000000000000000000)

(define (good-enough? guess x)
  (< (abs (/ (- (improve guess x)
		guess)
	     guess))
     0.001))

(sqrt 0.000009)
(sqrt 900000000000000000000000000000000000000000000000000000000000000000000000000000000000)
