(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
a-plus-abs-b
(a-plus-abs-b 10 -10)
(a-plus-abs-b 10 10)
