;; 符合函数repeated(f, n)=f(f(...(f(x))...)),n个f
;; 例如:f是x|->x+1,n次重复是x|->x+n
;;      f是x|x^2,nci重复是x|->x^(2^n)
;;      ((repeated square 2) 5) ->625
;; 错误
(define (repeated f n)
    (if (= n 1)
        f
        (repeated (lambda(x)
                    (f (f x))) (- n 1))))
;; 纠正,f(f(...f(x)...))=f(  f(...f(x)...) )(即f(repeated f n-1次))
(define (repeated f n)
  (if (= n 1)
      f
      (lambda(x)
        (f ((repeated f (- n 1)) x)))))
((repeated square 2) 5)

;; 使用compose
(load (absolute "c01/ex1.42.scm"))
(define (repeated f n)
  (if (= n 1)
      f
      (repeated (compose f f) (- n 1))))
;; 纠正
(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))
((repeated square 3) 2)
((repeated square 2) 5)

(repeated f n)

;; 代换模型
(repeated square 4)
(lambda (x)
  (square ((repeated square 3)
           x)))
(lambda (x)
  (square (
           (lambda(x)
             (square ((repeated square 2)
                      x)))
           x)))
(lambda (x)
  (square ((lambda(x)
             (square (
                      (lambda(x)
                        (square ((repeated square 1)
                                 x)))
                      x)))
           x)))
(lambda (x)
  (square ((lambda(x)
             (square (
                      (lambda(x)
                        (square ((lambda (x) (square x))
                                 x)))
                      x)))
           x)))
