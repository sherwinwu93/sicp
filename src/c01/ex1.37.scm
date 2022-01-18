;; 无限连
(define (cont-frac n d k)
  (define (recur i)
    (if (= i k)
	(/ (n i)
	   (d i))
	(/ (n (- i 1))
	   (+ (d (- i 1))
	      (recur (+ i 1))))))
  (recur 1))

;; 检验
;; k多大,4位精度, k=100时
(cont-frac (lambda(i) 1.0)
	   (lambda(i) 1.0)
	   100)

(define (cont-frac n d k)
  (define (iter i ans)
    (if (= i 1)
	ans
	(iter (- i 1)
	      (/ (n (- i 1))
		 (+ (d (- i 1))
		    ans)))))
  (iter k (/ (n k)
	     (d k))))

