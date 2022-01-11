;; 递归版本
(define (f-recur n)
  (if (< n 3)
      n
      (+ (f-recur (- n 1))
	 (* 2
	    (f-recur (- n 2)))
	 ( * 3
	     (f-recur (- n 3))))))

(f-recur 10)

;; 迭代版本
(define (f n)
  (f-iter 0 1 2 n))
(define (f-iter a b c n)
  (if (= n 0)
      a
      (f-iter b
	      c
	      (+ c
		 (* 2 b)
		 (* 3 a))
	      (- n 1))))
(f 10)
