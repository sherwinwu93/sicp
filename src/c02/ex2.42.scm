(load-r "c02/p76-sum-odd-squares$even-fib.scm")
(load-r "c02/p83-flatmap.scm")
;; 八皇后问题: 八皇后在8x8宫格中,互相不在同一行,同一列,同一对角线上
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        ;; (list empty-board)
        (list ())
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda(rest-of-queens)
            (map (lambda(new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (adjoin-position new-row k rest-of-queens)
  (append (list (list new-row k)) rest-of-queens))

(adjoin-position 1 3 (list (list 3 2) (list 5 1)))

(define (safe? k positions)
  (if (or (null? positions) (= k 1))
      true
      (let ((p0 (car positions))
            (p1 (cadr positions)))
        (let ((x0 (car p0))
              (y0 (cadr p0))
              (x1 (car p1))
              (y1 (cadr p1)))
          (cond ((= x0 x1) false)
                ((= y0 y1) false)
                ((= (abs (- x0 x1)) (abs (- y0 y1))) false)
                (else true))))))
(safe? 3 (list (list 1 2) (list 3 1)))

(queens 5)
