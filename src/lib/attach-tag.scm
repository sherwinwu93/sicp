(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (car datum))
(define (contents datum)
  (cdr datum))