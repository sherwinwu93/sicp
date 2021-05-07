;; 平滑:信号处理的重要概念
;; 有函数f(x),dx是非常小的值,f的平滑函数s,s在点x的值是f(x-dx)`f(x)`f(x+dx)的平均值
;; 写出该平滑过程smooth(f),返回一个过程
;; 利用smooth和1.43的repeated,生成n次平滑函数.

;; n次平滑函数过程, wishful thinking
(define (smooth-n f n)
  (repeated (smooth f) n))
;; 纠正,一个是重复smooth,一个是重复smooth之后的函数
;; 微妙的细节不得不注意
(define (smooth-n-times f n)
  (let ((n-times-smooth (repeated smooth n)))
    (n-times-smooth f)))

(repeated smooth n)
(smooth (repeated smooth (- n 1)))
(smooth (smooth (repeated smooth (- n 2))))

((smooth-n-times square 10) 5)

;; 载入repeated
(load (absolute "c01/ex1.43.scm"))

;; 平滑函数过程
(define (smooth f)
  (lambda(x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3)))
(define dx 0.00001)
((smooth square) 5)
