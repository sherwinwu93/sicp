#lang racket


(require racket/draw)
(require racket/gui)

;; -vector
;; ex2.46 从原点出发的两位向量v由x和y的序对表示.
;;        数据抽象: make-vect,xcor-vect,ycor-vect
(define (make-vect x y)
  (cons x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))
;; 使用层
;; 过程add-vect,sub-vect和scale-vect
(define (add-vect v1 v2)
  (let ((x1 (xcor-vect v1))
        (y1 (ycor-vect v1))
        (x2 (xcor-vect v2))
        (y2 (ycor-vect v2)))
    (make-vect (+ x1 x2)
               (+ y1 y2))))
(define (sub-vect v1 v2)
  (let ((x1 (xcor-vect v1))
        (y1 (ycor-vect v1))
        (x2 (xcor-vect v2))
        (y2 (ycor-vect v2)))
    (make-vect (- x1 x2)
               (- y1 y2))))
(define (scale-vect s v)
  (let ((x (xcor-vect v))
        (y (ycor-vect v)))
    (make-vect (* s x)
               (* s y))))

;; -Segment
;; ex2.48 直线用一对向量表示
;;        直线的数据抽象:make-segment,start-segment和end-segment,构建在向量的数据抽象上
(define (make-segment v1 v2)
  (cons v1 v2))
(define (start-segment s)
  (car s))
(define (end-segment s)
  (cdr s))

;; -Frame
;; ex2.47 框架的两种可能的数据抽象
;;        frame的数据抽象:make-frame,origin-frame,edge1-frame,edge2-frame,dc
;; 第二种构造器
(define (make-frame origin edge1 edge2 dc)
  (list origin cons edge1 edge2 dc))
(define (origin-frame f)
  (car f))
(define (edge1-frame f)
  (cadr f))
(define (edge2-frame f)
  (caddr f))
(define (dc f)
(cadddr f))

(define (frame-coord-map frame)
  (lambda(v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

;; -Painter Generators
;; painter:画家(基本元素)
;; 画家:一个过程,以框架为参数,通过位移和伸缩,画出与框架匹配的图.
;; (define (segments->painter segment-list)
;;   (lambda (frame)
;;     (for-each
;;      (lambda(segment)
;;        (draw-line
;;         ((frame-coord-map frame) (start-segment segment))
;;         ((frame-coord-map frame) (end-segment segment))))
;;      segment-list)))
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (let ((start ((frame-coord-map frame) (start-segment segment)))
             (end ((frame-coord-map frame) (end-segment segment))))
         (send (dc frame) draw-line
               (xcor-vect start)
               (ycor-vect start)
               (xcor-vect end)
               (ycor-vect end))))
     segment-list)))

;; -Painters

;; -Transformer Generator

;; -Transformers

;; -wave

;; -Wave 2

;; -Wave 4

;; -flipped-pairs: Should look the same as Wave 4

;; -right-split

;; -up-split

;; -corner-split

;; -square-limit
