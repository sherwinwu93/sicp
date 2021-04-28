;; 迭代式改进: 例如average-damp, 牛顿迭代法
;;            一般性计算策略:计算某个结果
;;                           猜初始值,足够好,输出结果;不够好,提升初始值,循环
;; 写出过程iterative-improve, 以两个过程为参数,good-enough?, improve
;; 并且重写sqrt过程和fixed-point过程

;; sqrt过程
(define (sqrt x)
  (sqrt-iter 1.0 x))
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))
(define (improve guess x)
  (average guess (/ (x guess))))
(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

;; 不动点; f(x)=x
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
(define tolerance 0.00001)

;; 写出过程iterative-improve, 以两个过程为参数,good-enough?, improve
;; 返回一个过程
(define (iterative-improve good-enough? improve)
  (define (recur guess)
    (if (good-enough? guess)
        guess
        (recur (improve guess))))
  recur)
;; lambda可以继续定义局部过程,当需要递归时,可以使用
(define (iterative-improve good-enough? improve)
  (lambda(first-guess)
    (define (try guess)
      (if (good-enough? guess)
          guess
          (try (improve guess))))
    (try first-guess)))

;; 使用iterative-improve重新定义sqrt
(define (sqrt x first-guess)
  ((iterative-improve (lambda(guess)
                        (< (abs (- (square guess) x)) 0.0001))
                      (lambda(guess)
                        (average guess (/ x guess))))
   first-guess))
(sqrt 4 1.0)
;; 使用iterative-improve重新定义fixed-point
(define (fixed-point f first-guess)
  ((iterative-improve (lambda(y)
                        (< (abs (- y (f y))) 0.00001))
                      (lambda(y)
                        (f y)))
   first-guess))
(fixed-point (lambda(y) (average y (/ 4 y))) 1.0)
