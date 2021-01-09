;; sine函数
(define (cube x) (* x x x))
(define (p x)
  (- (* 3 x)
     (* 4 (cube x))))
(define (sine angle)
  (display "sine")
  (display "\n")
  (if (not (> (abs angle)
              0.1))
      angle
      (p (sine (/ angle 3.0)))))
(sine 12.15)
;; 求调用多少次？ 7次
;; 时空复杂度
