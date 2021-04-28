;; 平均阻尼: y|->x/y的不动点
;;           y|->x/y^2的不动点:立方根
;;           y|->x/y^3的不动点:四次方根不收敛,再做一次平均阻尼,收敛了
;; 确定y|->x/y^(n-1)收敛需要的平均阻尼次数
;; 实现一个过程,使用fixed-point`average-damp和1.43的repeated计算n次方根.
;; 平方根的平均阻尼次数1
(define (sqrt x)
  (fixed-point (average-damp (lambda(y) (/ x y)))
               1.0))
(sqrt 4.0)
;; 立方根average-damp 1
(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))
(cube-root 8)


;; 四次方根
(define (four-root x)
  (fixed-point (repeated (average-damp (lambda(y) (/ x (cube y))))
                         2)
               1.0))

(four-root 16)


(define (average x y)
  (/ (+ x y) 2))
(load "p46-fixed-point.scm")
(load "ex1.43.scm")
;; n次方根
(load "p30-fast-expt.scm")
(disk-save "image2")
(disk-restore "image2")
(define (n-root x n times)
  ;; (let ((times (if (= (remainder n 2) 0)
  ;;                  (/ n 2)
  ;;                  (/ (+ n 1) 2))))
        (fixed-point (repeated (average-damp (lambda(y) (/ x (fast-expt y (- n 1)))))
                               times)
                     1.0))
(n-root 4 9 2)

(define (n-root x n)
  (let ((times (if (< (remainder n 6) 4)
                   1
                   2)))
    (fixed-point (repeated (average-damp (lambda(y) (/ x (fast-expt y (- n 1)))))
                           times)
                 1.0)))
(n-root 100 7)
