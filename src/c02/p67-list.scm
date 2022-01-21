(define one-through-four (list 1 2 3 4))
one-through-four
(cons 1
      (cons 2
	    (cons 3
		  (cons 4 '()))))
;; (1 2 3 4) 只是打印的方式
;; 如果n=0, 直接返回表的car
;; 否则, list-ref返回表的cdr的n-1个项
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
(define squares (list 1 4 9 16 25))
(list-ref squares 3)

;; 如果空表,length为0
;; 否则length=表的cdr的length+1
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define (length items)
  (define (length-iter a count)
    (if (null? a)
	count
	(length-iter (cdr a) (+ 1 count))))
  (length-iter items 0))

;; append的实现
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

