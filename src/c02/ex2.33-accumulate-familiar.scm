(load-r "c02/p76-convention-interface.scm")
;; 一些基本的表操作看作累积的定义
(define (map p sequence)
  ;; x是sequence的car部门,y是(map p (cdr sequence)
  (accumulate (lambda(x y)  (cons (p x) y))
	      ()
	      sequence))

(map square (list 1 2 3))

(define (append seq1 seq2)
  ;; x是seq1的car, y是 (append (cdr seq1) seq2)
  (accumulate cons
	      seq2
	      seq1))

(append (list 1 2 3) (list 4 5 6))

(define (length sequence)
  (accumulate (lambda(x y) (+ 1 y))
	      0
	      sequence))
(length (list 1 2 3))
