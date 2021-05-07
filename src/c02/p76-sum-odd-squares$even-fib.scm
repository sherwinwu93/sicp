(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))
(sum-odd-squares (list 1 (list 2 3) 4 5))

(load (absolute "c01/p26-fib.scm"))
(define (even-fibs n)
  (define (next k)
    (if (> k n)
        ()
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))
(even-fibs 10)

;; filter:过滤器
(define (filter predicate sequence)
  (cond ((null? sequence) ())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
(filter odd? (list 1 2 3 4 5 6 7))

;; accumulate:累积工作
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
(accumulate + 0 (list 1 2 3 4 5))
(accumulate * 1 (list 1 2 3 4 5))
(accumulate cons () (list 1 2 3 4 5))

;; enumerate:枚举器
(define (enumerate-interval low high)
  (if (> low high)
      ()
      (cons low (enumerate-interval (+ low 1) high))))
(enumerate-interval 2 7)
;; enumerate:树叶枚举器
(define (enumerate-tree tree)
  (cond ((null? tree) ())
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
(enumerate-tree (list 1 (list 2 (list 3 4)) 5))

;; 序列作为约定界面
(define (sum-odd-squares tree)
  (accumulate +
              0
              (map square
                   (filter odd?
                           (enumerate-tree tree)))))
(sum-odd-squares (list 1 (list 2 3) 4 5))

(define (even-fibs n)
  (accumulate cons
              ()
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))
(even-fibs 4)

;; 再用来研究新例子,fib的平方序列
(define (list-fib-squares n)
  (accumulate cons
              ()
              (map square
                   (map fib
                        (enumerate-interval 0 n)))))
(list-fib-squares 10)

;; 所有奇数的平方之乘积
(define (product-of-squares-of-odd-elements sequence)
  (accumulate *
              1
              (map square
                   (filter odd? sequence))))
(product-of-squares-of-odd-elements (list 1 2 3 4 5))

;; 薪水最高的程序员
(define (salary-of-highest-paid-programmer records)
  (accumulate max
              0
              (map salary
                   (filter programmer? records))))
