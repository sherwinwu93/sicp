(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))

          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))
;; loop里面用临时变量temp保存x的cdr的值,下一行的set-cdr!破坏这个cdr.
;; 一般性解释mystery做了什么.假定v通过(define v (list 'a 'b 'c 'd)),画出v的盒子指针
;; 现在求值(define w (mystery v)),画出求值之后v和w的模型,以及打印出来是什么
;; a. mystery做了什么?
;; 答: 不断去除x的car部分,拼接到新的list里面,修改版的reverse(和构造版相对)
;; b. v的模型
;; c. w的模型
;; 答:求值后v成为空列表,w则是新列表且内容和原来的v一致
