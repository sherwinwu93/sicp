(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
(trace gcd)

;; 应用序 4次
(gcd 206 40)
(gcd 40 6) ;; (gcd 40 (r 206 40))
(gcd 6 4)  ;; (gcd 6 (r 40 6))
(gcd 4 2)  ;; (gcd 4 (r 6 4))
(gcd 2 0)  ;; (gcd 2 (r 4 2))
2

;; 正则序 time=O(fib(n)),被最大公约数的数一定大于fib(n),因为每次取余必然减少超过1
(gcd 206 40)
(if (= 40 0) ...)
(gcd 40 (r 206 40)) ;;(gcd 40 6)
(if (= t1 0) ...);; t1=(r 206 40) 1
(gcd t1 (r 40 t1)) ;;(gcd 40 6)
(if (= t2 0) ...);; t2=(r 40 t1) 2
(gcd t2 (r t1 t2)) ;;(gcd 6 4)
(if (= t3 0) ...);; t3=(r t1 t2) 1+2 +1 = 4
(gcd t3 (r t2 t3)) ;;(gcd 4 2)
(if (= t4 0) ...);; t4=(r t2 t3) 2+4 +1 = 7


1+2+4+7+7=21 
