;; 绘图的准备工作
;; 注意图只有-1，1大小
(define device (make-graphics-device (car (enumerate-graphics-types))))
;; 定义划线的过程
(define (draw-line v1 v2)
  (graphics-draw-line device
                      (xcor-vect v1)
                      (ycor-vect v1)
                      (xcor-vect v2)
                      (ycor-vect v2)))
(define v1 (make-vect 0 0))
(define v2 (make-vect 1 1))
(define v3 (make-vect 1 0))
(define v4 (make-vect 0 1))
(define v5 (make-vect 0 1))
(define v6 (make-vect 0 -1))
(draw-line v1 v2)
(draw-line v3 v4)
(draw-line v5 v6)


;; 将wave4的模式抽象出来
; (define (flipped-pairs painter)
;   (let ((painter2 (beside painter (flip-vert painter))))
;     (below painter2 painter2)))
;; 重新定义wave4
; (define wave4 (flipped-pairs wave))

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


(define unit-frame (make-frame (make-vect 0 500) (make-vect 500 0) (make-vect 0 -500)))
(x-painter unit-frame)
;; a.画出给定框架边界的画家

; Vector
;; ex2.46 从原点出发的两位向量v由x和y的序对表示.
;;        数据抽象: make-vect,xcor-vect,ycor-vect
(define (make-vect x y)
  (cons x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))
;; 测试
(xcor-vect (make-vect 0 1))
(ycor-vect (make-vect 0 1))
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

; Segment
;; ex2.48 直线用一对向量表示
;;        直线的数据抽象:make-segment,start-segment和end-segment,构建在向量的数据抽象上
(define (make-segment v1 v2)
  (cons v1 v2))
(define (start-segment s)
  (car s))
(define (end-segment s)
  (cdr s))

; Frame
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
  (cadr (cdr f)))
(define f (make-frame 1 2 3))
(origin-frame f)
(edge1-frame f)
(edge2-frame f)

;; 第二种构造器
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame f)
  (car f))
(define (edge1-frame f)
  (car (cdr f)))
(define (edge2-frame f)
  (cdr (cdr f)))

;; 将点映射到其他frame的过程
(define (frame-coord-map frame)
  (lambda(v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))
(define sub-frame (make-frame (make-vect 0 0)
                              (make-vect 0.3 0)
                              (make-vect 0 0.5)))
((frame-coord-map sub-frame) (make-vect 1 1))
; Painter Generators
;; painter:画家(基本元素)
;; 画家:一个过程,以框架为参数,通过位移和伸缩,画出与框架匹配的图.
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda(segment)
       (display 
        ((frame-coord-map frame) (start-segment segment)))
       (display ((frame-coord-map frame) (end-segment segment)))
       (newline)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))
(define s1 (make-segment
            (make-vect 0 0)
            (make-vect 0.8 0.8)))
(define s2 (make-segment
            (make-vect 0.8 0)
            (make-vect 0.8 0.8)))
((segments->painter (list s1 s2)) unit-frame)

; Painters
;; ex2.49 利用segments->painter定义基本画家
(define unit-frame
  (make-frame (scale-vect 0.99 (make-vect -1 -1))
              (scale-vect 0.99 (make-vect 2 0))
              (scale-vect 0.99 (make-vect 0 2))))
((frame-coord-map unit-frame) (make-vect 0.5 1))
;; a.框架边界的画家
(define top (make-segment (make-vect 0 1)
                          (make-vect 1 1)))
(define right (make-segment (make-vect 1 1)
                            (make-vect 1 0)))
(define bottom (make-segment (make-vect 0 0)
                             (make-vect 1 0)))
(define left (make-segment (make-vect 0 0)
                           (make-vect 0 1)))

(define device (make-graphics-device (car (enumerate-graphics-types))))
(define (border-painter frame)
  ((segments->painter (list top right bottom left)) frame))
(border-painter unit-frame)

;; b.大X
(define first (make-segment (make-vect 0 0)
                             (make-vect 1 1)))
(define second (make-segment (make-vect 1 0)
                              (make-vect 0 1)))
(define device (make-graphics-device (car (enumerate-graphics-types))))
(define (x-painter frame)
  ((segments->painter (list first second)) frame))
(x-painter unit-frame)
;; c.菱形
(define tl (make-segment (make-vect 0.5 1)
                         (make-vect 0 0.5)))
(define tr (make-segment (make-vect 0.5 1)
                         (make-vect 1 0.5)))
(define br (make-segment (make-vect 1 0.5)
                         (make-vect 0.5 0)))
(define bl (make-segment (make-vect 0 0.5)
                         (make-vect 0.5 0)))

(define (rhombus-painter frame)
  ((segments->painter (list tl tr br bl)) frame))
(rhombus-painter unit-frame)
;; d. wave
(define a-l (make-segment (make-vect 0.5 1)
                          (make-vect 0 0)))
(define a-r (make-segment (make-vect 0.5 1)
                          (make-vect 0.7 0.5)))
(define a-c (make-segment (make-vect 0.2 0.5)
                          (make-vect 0.7 0.5)))
(define (wave frame)
  ((segments->painter (list a-l a-r a-c)) frame))
(wave unit-frame)
; Transformer Generator
;; transform-painter 画家的变换 变换生成画家的信息
;;  完成对框架的变换后，再根据新框架产生画家
;; painter: 原画家
;; origin: 原原点
;; corner1: x边界
;; corner2: y边界
(define (transform-painter painter origin corner1 corner2)
  (lambda(frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))
;; 上下反转画家
(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))
((flip-vert wave) unit-frame)
;; 收缩到右上1/4的区域
(define (shrink-to-upper-right painter)
  (transform-painter painter
                     (make-vect 0.5 0.5)
                     (make-vect 1.0 0.5)
                     (make-vect 0.5 1.0)))
((shrink-to-upper-right wave) unit-frame)
;; 逆时针旋转90度
(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))
((rotate90 wave) unit-frame)
;; 向中心收缩
(define (squash-inwards painter)
  (transform-painter painter
                     (make-vect 0.0 0.0)
                     (make-vect 0.65 0.35)
                     (make-vect 0.35 0.65)))
((squash-inwards wave) unit-frame)

;; 前提条件：存在wave，随框架变形或者改变大小画出图形
;; 基本元素 painter
;; 基本操作 beside: 第一个左边,第二个右边, below:第一个下边,第二个上边, flip-vert 上下颠倒, flip-horiz: 水平翻转
;; 组合
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))
((beside wave wave) unit-frame)
;; ex2.50 水平翻转画家
(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))
(define device (make-graphics-device (car (enumerate-graphics-types))))
((flip-horiz wave) unit-frame)

(define (rotate180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))
(define device (make-graphics-device (car (enumerate-graphics-types))))
((rotate180 wave) unit-frame)
(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))
((rotate270 wave) unit-frame)
;; ex2.51
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((bottom-painter (transform-painter painter1
                                             (make-vect 0.0 0.0)
                                             (make-vect 1.0 0.0)
                                             split-point))
          (top-painter (transform-painter painter2
                                          split-point
                                          (make-vect 1.0 0.5)
                                          (make-vect 0.0 1.0))))
      (lambda(frame)
        (bottom-painter frame)
        (top-painter frame)))))
(define (below painter1 painter2)
  (let ((rt1 (rotate270 painter1))
        (rt2 (rotate270 painter2)))
    (rotate90 (beside rt1 rt2))))
(define device (make-graphics-device (car (enumerate-graphics-types))))
((below wave wave) unit-frame)
; Transformers
; wave
; wave2
(define wave2
  (beside wave (flip-vert wave)))
(define device (make-graphics-device (car (enumerate-graphics-types))))
(wave2 unit-frame)
;wave4
(define wave4
  (below wave2 wave2))
(wave4 unit-frame)
;;square-limit
;;ex2.52
;; a. wave增加线段
(define (wave frame)
  ((segments->painter
    (list  (make-segment (make-vect 0.5 1)
                         (make-vect 0 0))
           (make-segment (make-vect 0.5 1)
                         (make-vect 0.7 0.5))
           (make-segment (make-vect 0.2 0.5)
                         (make-vect 0.7 0.5))
           (make-segment (make-vect 0.5 1.0)
                         (make-vect 0.5 0.5))))
   frame))
;; 定义递归
;; 右边做分割和分支
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))
(define device (make-graphics-device (car (enumerate-graphics-types))))
((right-split wave 4) unit-frame)
;; ex2.44.scm, 上边做分割和分支
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
(define device (make-graphics-device (car (enumerate-graphics-types))))
((up-split wave 4) unit-frame)
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
(define device (make-graphics-device (car (enumerate-graphics-types))))
((corner-split wave 4) unit-frame)
;; b.修改corner-split的构造模式,只用up-split或right-split的一个
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((sub (up-split painter (- n 1)))
            (b-sub (up-split (rotate90 painter) (- n 1))))
        (let ((top-left (beside sub sub))
              (bottom-right (below (rotate270 b-sub) (rotate270 b0sub)))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))
;; c.sqaure-limt,一种使用square-of-four，另一种不同模式组合各个角区

;; square-of-four t1:上左 ; tr:上右 ;bl:下左 ;br:下右, t1 painter 生成新的painter
;; 基于四个painter,生成新painter
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))
;; 使用square-of-four
(define (square-limit painter n)
  (let (quarter (corner-split painter n))
    (square-of-four quarter quarter quarter quarter))
(define device (make-graphics-device (car (enumerate-graphics-types))))
((square-limit wave 10) unit-frame)
;; 普通组合
(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))
