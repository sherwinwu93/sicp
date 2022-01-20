;; -------------------- 实现1
(define (make-rat n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))
;;print
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

;; -------------------- 实现2
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g)
	  (/ d g))))
(define (numer x) (car x))
(define (denom x) (cdr x))
;; -------------------- 实现3
(define (make-rat n d) (cons n d))
(define (numer x)
  (let ((g (gcd (car x) (cdr x)))
	(car x))))
(define (denom x)
  (let ((g (gcd (car x) (cdr x)))
	(cdr x))))
