;; square-list的迭代错误版本,顺序相反
;; 答:因为当前产生的值位于之前答案的前面,所以顺序相反
(square-list (list 1 2 3 4))
-> (16 9 4 1)
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items ()))
;; 错误迭代版本2
;; 答:产生的是((() 1) 4),这种结构.与表结构不同
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items ()))
;; 纠正:可以用reverse作处理
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter (reverse items) ()))

(square-list (list 1 2 3 4))
