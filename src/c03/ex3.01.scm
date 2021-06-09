;; 累加器过程make-accumulator
(define (make-accumulator count)
  (lambda (offset)
    (begin (set! count (+ count offset))
           count)))
(define A (make-accumulator 5))
(A 10)
15
(A 10)
25
