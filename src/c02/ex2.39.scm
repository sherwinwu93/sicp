(load (absolute "c02/ex2.38.scm"))
;; 基于flod-right和fold-left完成练习reverse
(define (reverse sequence)
  (fold-right (lambda(x y)
                (append y (list x)))
              ()
              sequence))
(reverse (list 1 2 3))

(define (reverse sequence)
  (fold-left (lambda(x y)
                (cons y x))
              ()
              sequence))
