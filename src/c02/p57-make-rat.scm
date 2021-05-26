;; 构造器
(define (make-rat n d)
  (cons n d))

;; 选择器
(define (numer x) (car x))
(define (denom x) (cdr x))

;; 打印过程
(define (print-rat x)
  (if (= (remainder (numer x) (denom x)) 0)
      (/ (numer x) (denom x))
      (
       (newline)
       (display (numer x))
       (display "/")
       (display (denom x)))))

;; 实验有理数过程
(define one-third (make-rat 1 3))
(print-rat (add-rat one-third one-third))
;; 改良构造器
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))
;; 改良选择器
(define (numer x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (car x) g)))
(define (denom x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (cdr x) g)))
