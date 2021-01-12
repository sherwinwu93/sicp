;; 预备条件
(define (inc x)
  (- x -1))
(define (dec x)
  (- x 1))

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

(+ 3 8)
;; 11

(define (+ a b)
 (if (= a 0)
      b
      (+ (dec a) (inc b))))
(+ 7 8)
;; 15
