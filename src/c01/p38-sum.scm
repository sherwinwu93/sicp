;; a到b的各整数之和
(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))
(sum-integers 2 8)
;; a到b的立方之和
(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))
(sum-cubes 1 3)
;; 1/(1*3)+1/(5*7)+1/(9*11)...
(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1 (* a (+ a 2))) (pi-sum (+ 4 a) b))))
(pi-sum 1 10)

;; 直接对于数学概念,进行形式化的描述
;; (define (<name> a b)
;;   (if (> a b)
;;       0
;;       (+ <term> (<name> <next> b))))
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (sum-cubes a b)
  (define (inc n) (+ n 1))
  (sum cube a inc b))
;; 新的立方和
(sum-cubes 1 3)
;; 新的sum-integers
(define (sum-integers a b)
  (define (indentify x) x)
  (define (inc n) (+ n 1))
  (sum indentify a inc b))
(sum-integers 1 5)
;; 新的pi-sum
(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))
(* 8 (pi-sum 1 100))
;; 定积分
(define (integral f a b dx)
  (define (term x)
    (f x))
  (define (next x)
    (+ x dx))
  (* dx (sum term (+ a (/ dx 2)) next b)))

(integral cube 0 1 0.0001)
