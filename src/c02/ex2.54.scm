;; 两个表元素相同,顺序相同,则equal?
;; #t
(equal? '(this is a list) '(this is a list))
;; #f
(equal? '(this is a list) '(this (is a) list))

;; 用eq?定义equal?
(define (equal? a b)
  (cond ((and (null? a) (null? b)) true)
        ((or
          (and (null? a) (not (null? b)))
          (and (null? b) (not (null? a))))
         false)
        (else (and (eq? (car a) (car b))
                   (equal? (cdr a) (cdr b))))))
(equal? () ())
(equal? () '(this))
(equal? '(this) ())
