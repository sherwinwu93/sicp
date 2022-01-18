;; 平滑函数是信号处理的重要概念
;; f函数,dx很小的常熟,smooth函数
(load-r "co1/ex1.43.scm")
(load-r "lib/math.scm")

(define smooth
  (define dx 0.00001)
  (lambda(f)
    (lambda(x)
      (average (f (- x dx))
	       (f x)
	       (f (+ x dx))))))

(define (smooth-n f)
  ((repeated smooth n) f))
