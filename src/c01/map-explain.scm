;; 对列表的元素按位置进行聚合
(map + '(1 2 3) '(4 5 6) '(7 8 9))
;; 对列表的所有进行运算
(define (double x) (* x 2))
(define (hanoi disk from to buffer)
  (display 'from)
  (display from)
  (display 'to)
  (display to)
  (display 'buffer)
  (display buffer)
  )

(let (s (hanoi 4 5 6 7))
  (map (lambda (x)
	 (display 'x))
       s))
