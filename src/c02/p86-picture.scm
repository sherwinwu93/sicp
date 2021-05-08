;; 绘图的准备工作
#lang racket/gui
(require graphics/graphics)
(open-graphics)
(define vp (open-viewport "A Picture Language" 500 500))

(define draw (draw-viewport vp))
(define (clear) ((clear-viewport vp)))
(define line (draw-line vp))

;; 基本元素 painter
;; 基本操作 beside: 第一个左边,第二个右边, below:第一个下边,第二个上边, flip-vert 上下颠倒, flip-horiz: 水平翻转
;; 组合
(define wave2
  (beside wave (flip-vert wave)))

(define wave4
  (below wave2 wave2))

;; 将wave4的模式抽象出来
(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))
;; 重新定义wave4
(define wave4 (flipped-pairs wave))

;; 定义递归
;; 右边做分割和分支
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))
;; ex2.44.scm, 上边做分割和分支
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
;; 向上和向右分支
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))
;; square-limit
(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

;; 画家的高级操作,抽象出画家的各种组合操作的模式
;;               把画家操作看作操控和描写这些元素的组合方法的元素
;;               以画家操作为参数,创建各种新的画家操作

;; square-of-four t1:上左 ; tr:上右 ;bl:下左 ;br:下右, t1 painter 生成新的painter
;; 基于四个painter,生成新painter
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))
;; 操作flipped-pairs基于square-of-four
(define (flipped-pairs painter)
  (let ((combine4 (square-of-four identity flip-vert
                                  identity flip-vert)))
    (combine4 painter)))
;; square-limit可以描述为
;; horiz:水平, vert:垂直
(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz identity
                                  rotate180 flip-vert)))))
;; ex2.45 right-split和up-split表述为split
(define right-split (split beside below))
(define up-split (split below beside))

(define (split first-direct second-direct)
  (lambda(painter n)
    (define (iter k)
      (if (= k 0)
          painter
          (let ((smaller (iter (- n 1))))
            (second-direct painter (first-direct smaller smaller)))))
    (iter n)))

(define (frame-coord-map frame)
  (lambda(v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame))))))

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

;; ex2.47 框架的两种可能的数据抽象
;;        frame的数据抽象:make-frame,origin-frame,edge1-frame,edge2-frame
;; 第一种构造器
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame f)
  (car f))
(define (edge1-frame f)
  (cadr f))
(define (edge2-frame f)
  (cadr (cad f)))

;; 第二种构造器
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame f)
  (car f))
(define (edge1-frame f)
  (car (cdr f)))
(define (edge2-frame f)
  (cdr (cdr f)))
;; painter:画家(基本元素)
;; 画家:一个过程,以框架为参数,通过位移和伸缩,画出与框架匹配的图.
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda(segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))
;; ex2.48 直线用一对向量表示
;;        直线的数据抽象:make-segment,start-segment和end-segment,构建在向量的数据抽象上
(define (make-segemnt v1 v2)
  (cons v1 v2))
(define (start-segment s)
  (car s))
(define (end-segment s)
  (cdr s))

;; ex2.49 利用segments->painter定义基本画家
;; 绘图的示例
(define x-painter
  (segments->painter
   (list
    (make-segment (make-vect 0 0)
                  (make-vect 1 1))
    (make-segment (make-vect 0 1)
                  (make-vect 1 0)))))

(define unit-frame (make-frame (make-vect 0 500) (make-vect 500 0) (make-vect 0 -500)))
(x-painter unit-frame)
;; a.画出给定框架边界的画家
