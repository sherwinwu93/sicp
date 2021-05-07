(load (absolute "c01/p38-sum.scm"))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))
(integral cube 0 1 0.001)

(define (simpson f a b n)
  (define h (/ (- b a)
               n))
  (define (g k)
    (define j
        (/ (* h (f (+ a (* k h)))) 3.0))
    (cond ((or (= 0 k) (= n k)) j)
          ((even? k) (* 2 j))
          (else (* 4 j))))
  (define (iter f a b k n)
    (if (> k n)
        0
        (+ (g k)
           (iter f a b (+ k 1) n))))
  (iter f a b 0 n))
(simpson cube 0 1 1000)

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (term k)
    (define f-result
      (f (+ a (* k h))))
    (cond ((or (= k 0) (= k n))
           (/ (* h f-result) 3))
          ((even? k)
           (/ (* 4 h f-result) 3))
          (else
           (/ (* 2 h f-result) 3))))
  (exact->inexact (sum term 0 1+ n)))
