;; accumulate也称为fold-right,将序列第一个元素组合到右边所有元素的组合结果上.
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (accumulate op initial (cdr sequence)))))
(define fold-right accumulate)
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
	result
	(iter (op result (car rest))
	      (cdr rest))))
  (iter initial sequence))

(fold-right / 1 (list 1 2 3))
;; 递归在左,计算在右
;; 3被2除 2/3, 1/(2/3) 3/2
;; 迭代在左,计算在左
(fold-left / 1 (list 1 2 3))
;; (iter 1 (list 1 2 3))
;; (iter 1/1 (list 2 3))
;; (iter 1/2 (list 3))
;; (iter (1/2)/3 (list))
;; 1/6
(fold-right list () (list 1 2 3))
'()
'(3 ())
'(2 (3 ()))
'(1 (2 (3 ())))


(fold-left list () (list 1 2 3))
'()
'(() 1)
'((() 1) 2)
'(((() 1) 2) 3)
