(define (single-operand? a)
  (and (pair? a)
       (null? (cdr a))))
(single-operand? '(a b))
