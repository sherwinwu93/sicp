;; 递归计算过程
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
	 (* (f (- n 2)) 2)
	 (* (f (- n 3)) 3))))
(f 5) 25
(f 6) 59

;; 迭代计算过程
(define (f n)
  (f-iter 0 1 2 n))

(define (f-iter a b c n)
  (if (= n 0)
      a
      (f-iter b ;;new a
	      c ;;new b
	      (+ c
		 (* 2 b)  
		 (* 3 a)) ;;new c
	      (- n 1))))
(f 5)

	      
