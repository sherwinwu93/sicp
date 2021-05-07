(load (absolute "c02/p76-sum-odd-squares$even-fib.scm"))

;; 将count-leaves定义为一个累积
(define (count-leaves t)
  (accumulate +
              0
              (map (lambda(x) 1)
                   (enumerate-tree t))))
(count-leaves (list 1 2 (list 3 4)))
