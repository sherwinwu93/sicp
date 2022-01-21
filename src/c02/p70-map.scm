;; 对表的映射 map
(define (scale-list items factor)
  (if (null? items)
      ()
      (cons (* (car items) factor)
	    (scale-list (cdr items) factor))))
(scale-list (list 1 2 3 4 5) 10)
;; 抽象出来
(define (map proc items)
  (if (null? items)
      ()
      (cons (proc (car items))
	    (map proc (cdr items)))))
;; 多参数实现
;; todo
(map abs (list -10 2.5 -11.6 17))

(map (lambda (x) (* x x))
     (list 1 2 3 4))

(define (scale-list items factor)
  (map (lambda(x) (* x factor))
       items))
