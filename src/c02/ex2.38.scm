;; 过程accumulate别名fold-right,将序列的第一个元素组合到右边所有元素的组合结果上
;; fold-left,按照相反方向去操作各个元素
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

;; 下面表达式的值
;; 3 / 1, 2/3, 1/(2/3)   3/2
(fold-right / 1 (list 1 2 3))
;; 1/1(initial),1/2, (1/2)/3   1/6
(fold-left / 1 (list 1 2 3))
;; (3 ()),(2 (3 ())),(1 (2 (3 ())))
(fold-right list () (list 1 2 3))
;; (() 1),((() 1) 2),(((() 1) 2) 3)
(fold-left list () (list 1 2 3))

;; 什么时候产生同样的结果,(op a b)=(op b a)时,产生相同的结果
;; 比如:*,+
