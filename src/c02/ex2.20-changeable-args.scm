;; 带点尾部记法
;; (define (f x y . z)  <body>)
;; 过程same-parity 相同奇偶行

(define (same-parity . list)
  (define (parity? x)
    (= (remainder x 2) 0))
  (define (same-parity-rec parity list1)
    (cond ((null? list1) '())
	  ((equal? parity (parity? (car list1)))
	   (cons (car list1)
		 (same-parity-rec parity (cdr list1))))
	  (else
	   (same-parity-rec parity (cdr list1)))))
  (same-parity-rec (parity? (car list)) list))

(same-parity  2 3 4 5 6 7)
