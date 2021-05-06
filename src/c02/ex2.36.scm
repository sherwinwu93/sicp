(load "./p76-sum-odd-squares$even-fib.scm")
;; 第三个参数是序列的序列,并且各个子序列的长度一样
;; ((1 2 3) (4 5 6) (7 8 9) (10 11 12)) -> (22 26 30)
(define s (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
(accumulate-n + 0 s)
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      ()
      (cons (accumulate op init (map (lambda(seq) (car seq)) seqs))
            (accumulate-n op init (map (lambda(seq) (cdr seq)) seqs)))))

