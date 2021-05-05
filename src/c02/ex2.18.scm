;; 写出过程reverse,反转列表
;; (25 16 9 4 1)
(reverse (list 1 4 9 16 25))
(my-reverse (list 1 4 9 16 25))
;; todo ???
(define (my-reverse list)
  (if (null? list)
      '()
      (cons (my-reverse (cdr list))
            (cons (car list) ()))))
(cons 1 (cons 2 (cons 3 ())))

(define (reverse list)
  (iter list '()))
(define (iter remained-items result)
  (if (null? remained-items)
      result
      (iter (cdr remained-items)
            (cons (car remained-items) result))))
