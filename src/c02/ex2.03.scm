(load "ex2.02.scm")

;; 矩形的周长
(define (retangele-perimeter r)
  (* 2 (+ (length-of-retangle r) (width-of-retangle r))))
;; 矩形的面积
(define (retangele-area r)
  (* (length-of-retangle r) (width-of-retangle r)))

;; 矩形的表示: 计算周长和面积
;; 第一种表示,用两条线段,选择:长宽
(define (make-retangle length width)
  (cons length width))
(define (length-of-retangle r)
  (segement-length (car r)))
(define (width-of-retangle r)
  (segement-length (cdr r)))
;; 测试
(define A (make-point 0 0))
(define B (make-point 1 0))
(define C (make-point 0 1))
(define L1 (make-segment A B))
(define L2 (make-segment A C))
(define R1 (make-retangle L1 L2))
(retangele-perimeter R1)
(retangele-area R1)

;; 第二种表示: 四条线段
(define (make-retangle length1 length2 width1 width2)
  (cons (cons length1 length2) (cons width1 width2)))
(define (length-of-retangle r)
  (segement-length (car (car r))))
(define (width-of-retangle r)
  (segement-length (car (cdr r))))
;;测试
(define A (make-point 0 0))
(define B (make-point 1 0))
(define C (make-point 0 1))
(define D (make-point 1 1))
(define L1 (make-segment A B))
(define L2 (make-segment A C))
(define L3 (make-segment C D))
(define L4 (make-segment B D))
(define R1 (make-retangle L1 L2 L3 L4))
(retangele-perimeter R1)
(retangele-area R1)
