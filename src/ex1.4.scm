(define (plus-abs a b)
  ((if(> b 0) + -)
   a
   b))
(plus-abs 10 -10)
(plus-abs 10 10)