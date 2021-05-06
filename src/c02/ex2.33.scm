;; 使用accumulate完成一些基本的表操作
(load "./p76-sum-odd-squares$even-fib.scm")
;; map
(define (map p sequence)
  (accumulate (lambda(x y)
                (cons (p x) y))
              ()
              sequence))
(map square (list 1 2 3))
;; append
(define (append seq1 seq2)
  (accumulate cons
              seq2
              seq1))
(append (list 1 2 3) (list 4 5))
;; length
(define (length sequence)
  (accumulate (lambda(x y)
                (1+ y))
              0
              sequence))
(length (list 1 2 3 5))
