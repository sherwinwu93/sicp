;; f(x)和g(x),f在g之后复合定义为x|->f(g(x).)
;; 定义compose实现函数复合.
;; 例如: inc是参数+1的函数,那么: ((compose square inc) 6) -> 49
(define (compose f g)
  (lambda(x)
    (f (g x))))
(define (inc x)
  (+ 1 x))
((compose square inc) 6)
((lambda(x) (square (1+ x))) 6)
(square (1+ 6))
(square 7)
49
