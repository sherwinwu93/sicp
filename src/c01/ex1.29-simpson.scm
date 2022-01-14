;; 辛普森积分,simpson
(load-r "lib/sum.scm")
(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (g i)
    (cond ((or (= i 1) (= i n)) (f (+ a (* i h))))
	  ((even? i)
	   (* 4 (f (+ a (* i h)))))
	  (else
	   (* 2 (f (+ a (* i h)))))))
  (/ (* h 
	(sum g
	     1
	     1+
	     n))
     3.0))
(load-r "lib/math.scm")
(simpson cube 0 1 10000)
(load-r "c01/p39-sum-integers.scm")
(integral cube 0 1 0.0001)
;;与结论相反,integral比simpson更精确
