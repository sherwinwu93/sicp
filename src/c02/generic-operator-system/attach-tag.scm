;; 兼容scheme-number版本
;; ex2.78
(define (attach-tag type-tag contents)
  (cond ((and (symbol? type-tag) (eq? type-tag 'scheme-number)) contents)
	(else (cons type-tag contents))))
(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
	(else (car datum))))
(define (contents datum)
  (cond ((number? datum) datum)
	(else (cdr datum))))
