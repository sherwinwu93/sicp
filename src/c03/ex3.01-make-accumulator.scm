(define (make-accumulator total)
  (lambda(cnt)
    (set! total (+ total cnt))
    total))
(define A (make-accumulator 5))
;; 15
(A 10)
;; 25
(A 10)
