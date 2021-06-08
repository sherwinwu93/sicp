;; 稠密多项式:表示(1 2 0 3 -2 -5)
;; 稀疏多项式:表示((100 1) (2 2) (0 1))

;; 稀疏
(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))
(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

;; 稠密
(define (adjoin-term term term-list)
  (cons (coeff term) term-list))
(define (the-empty-termlist) '())
(define (first-term term-list)
  (make-term (- (length term-list) 1) (car term-list)))
(define (rest-terms term-list)
  (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff)
  (cons order coeff))
(define (order term)
  (car term))
(define (coeff term)
  (cdr term))

(define t-list (the-empty-termlist))
(first-term (adjoin-term (make-term 2 3)
                         (adjoin-term (make-term 1 -2)
                                      (adjoin-term (make-term 0 -5) t-list))))
