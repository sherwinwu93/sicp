(define tolerance 0.00001)
;; 不动点; f(x)=x
;; 修改fixed-point,打印出计算的值序列
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (display guess)
      (newline)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
(fixed-point cos 1.0)
;; 找出x->log(1000)/log(x)的不动点,确定x^x=1000的一个跟
(fixed-point (lambda(x) (/ (log 1000)
                           (log x))) 2.0)
;; 比较采用平均阻尼和不用平均阻尼的步数
;; 平均阻尼:8次
;; 非:35次, 是4倍多
(fixed-point (average-damp (lambda (x) (/ (log 1000)
                                          (log x)))) 2.0)
