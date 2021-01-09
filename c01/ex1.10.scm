(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))
(a 1 10)
1024
(a 1 9)
512
(a 1 8)
256
2的n次方

(a 2 4)
65536
(a 2 1)
2 的1次方
(a 2 2)
2的2次方
(a 2 3)
2 的 4 次方
(a 2 4)
2的16次方
2的 x的(n - 1)次

(a 3 3)
65536
(define (f n)
  (a 0 n))
(f 10)
20
(define (g n)
  (a 1 n))
(g 10)
1024
(define (h n)
  (a 2 n))
(h 3)
16
(define (k n)
  (* 5 n n))
(k 4)
