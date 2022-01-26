;; 任意两个皇后不在同一行`同一列, 同一对角线
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
	(list empty-board) ; 直接为空
	(filter
	 (lambda(positions) (safe? k positions))
	 (flatmap
	  (lambda (rest-of-queens) ; k-1列放置k-1个皇后的某个方式
	    (map (lambda (new-row) ; new-row是k列放置的行编号
		   (adjoin-position new-row k rest-of-queens))
		 (enumerate-interval 1 board-size)))
	  (queen-cols (- k 1)))))) ; k-1列放置k-1个皇后的所有方式
  (queen-cols board-size))

;; 要完成程序,需要实现棋盘格局集合的表示方式
(define (make-position row column)
  (list row column))
(define (position-row position)
  (car position))
(define (position-column position)
  (cadr position))
;; 实现过程adjoin-position
(define (adjoin-position row column positions)
  (let ((new-position (make-position row column)))
    (append positions (list new-position))))
;; 定义empty-board 空格局集合
(define empty-board ())
;; safe? , 第k列的皇后是否安全
(define (k-position k positions)
  (if (= k 1)
      (car positions)
      (k-positions (- k 1) (cdr positions))))
(define ps (adjoin-position 3 3 (adjoin-position 2 2 (adjoin-position 1 1 ()))))

(define (safe-two? position another-position)
  (let ((r1 (position-row position))
	(c1 (position-column position))
	(r2 (position-row another-position))
	(c2 (position-column another-position)))
    (if (and (= r1 r2) (= c1 c2))
	true
	(and (not (= r1 r2))
	     (not (= c1 c2))
	     (not (= (- r1 r2) (- c1 c2)))))))
(define (safe? k positions)
  (let ((last (k-position k positions)))
    (null? (filter (lambda(position)
		     (not (safe-two? position last)))
		   positions))))

(queens 5)

;; 2.43 程序运行太慢了, 是原来的T的T次方???
;; todo
(flatmap
 (lambda(new-row)
   (map (lambda (rest-of-queens)
	  (adjoin-position new-row k rest-of-queens))
	(queen-cols (- k 1))))
 (enumerate-interval 1 board-size))
