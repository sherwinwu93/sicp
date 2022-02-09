(define device (make-graphics-device (car (enumerate-graphics-types))))
(graphics-clear device)
					; 这里定义一个划线的函数
(define (draw-line v1 v2)
  (graphics-draw-line device
                      (xcor-vect v1)
                      (ycor-vect v1)
                      (xcor-vect v2)
                      (ycor-vect v2)))
;; ------------------------------------------------------------
;; 图形语言: 数据抽象与闭包的威力
;; 某些元素重复出现,元素可以变形或者改变大小
;; 基本元素: 画家(给定矩形,画出对应的图形.变形或者改变大小)
;; 组合: beside above,flip-vert(垂直翻转) flip-horiz(水平翻转)
;; 抽象: wave4靠wave2抽象出来

;; 组合迅速增大复杂度
(define wave2
  ;; flip-vert 垂直翻转
  ;; beside 水平合并
  (beside wave (flip-vert wave)))
;; 组合
(define wave4
  (below wave2 wave2))
;; closure: 两个画家的beside或below还是画家
;; cons: cons序对后仍然得到序对

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))
;; 抽象出wave4,与上面的有区别是抽象出来的
(define wave4 (flipped-pairs wave))

;;
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
	(beside painter (below smaller smaller)))))
;; ------------------------------
;; ex2.44: 定义出up-split
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
	(below painter (beside smaller smaller)))))
;;
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

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))
(graphics-clear device)
((square-limit wave 12) frame-a)

;; ------------------------------------------------------------
;; 高级操作
;; 把画家操作看成是操作和描写这些元素的组合方法的元素
;; 写出以画家操作为参数,创建各种新的画家操作

;; 高级过程
;; 定义square-of-four: 四个格子放四个图案, 返回以painter为参数的过程
;;    可以用此来重新定义square-limit和flipped-pairs
(define (square-of-four tl tr bl br);tl tr bl br均为变换,旋转,翻转等等
  (lambda(painter)
    (let ((top (beside (tl painter) (tr painter)))
	  (bottom (beside (bl painter) (br painter))))
      (below bottom top))))
;; 使用square-of-four重新定义 flipped-pairs
(define (flipped-pairs painter)
  (let ((combine4 (square-of-four indentity flip-vert
				  indentity flip-vert)))
    (combine4 (corner-split painter n))))
;; 使用square-of-four重新定义 square-limit
(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz indentity
				  rotate180 flip-vert)))
    (combine4 (corner-split painter n))))

;; ------------------------------
;; ex2.45 对right-split和up-split进行抽象
(define (split op1 op2)
  (lambda(painter)
    (op1 painter
	 (op2 painter painter))))

(define right-split (split beside below))
(define up-split (split below beside))

;; ------------------------------------------------------------
;; 框架: 一个基准向量和两个角向量
;; make-frame, origin-frame, edge1-frame edge2-frame
;; v=(x,y) Origin(Frame) + x* Edge1(Frame) + y*Edge2(Frame)
;; 仍然返回了一个过程
(define (frame-coord-map frame)
  (lambda(v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
			   (edge1-frame frame))
	       (scale-vect (ycor-vect v)
			   (edge2-frame frame))))))
;;应用
;; ((frame-coord-map a-frame) (make-vect 0 0)) 返回 (origin-frame a-frame)

;; ------------------------------
;; ex2.46. 向量的数据抽象
(define make-vect list)
(define xcor-vect car)
(define ycor-vect cadr)
;; 实现向量加法add-vect`减法sub-vect`伸缩scale-vect
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

;; ------------------------------
;; ex2.47
;; 第一种数据抽象
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (cadr frame))
(define (edge2-frame frame)
  (caddr frame))

;; 第二种数据抽象
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (car (cdr frame)))
(define (edge2-frame frame)
  (cdr (cdr frame)))

;; ------------------------------------------------------------
;; 画家: 以框架为参数画出图像的过程
;;    例如: p是painter(画家), f是框架, (p f)就能产生f中p的图像
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda(segment)
       (draw-line
	((frame-coord-map frame) (start-segment segment))
	((frame-coord-map frame) (end-segment segment))))
     segment-list)))
;; ------------------------------
;; ex2.48
;; 利用2.46的向量定义出一种线段表示 make-segment, start-segment和end-segment
(define make-segment list)
(define start-segment car)
(define end-segment cadr)
;; ------------------------------
;; ex2.49 利用segments->painter定义下面的基本画家
;; a.画出给定框架的画家
(define painter-a
  (let ((O (make-vect 0 0))
	(A (make-vect 1 0))
	(B (make-vect 0 1))
	(C (make-vect 1 1)))
    (segments->painter (list (make-segment B O)
			     (make-segment O A)
			     (make-segment A C)
			     (make-segment C B)))))
(define frame-a (make-frame (make-vect -1 -1) (make-vect 2 0) (make-vect 0 2)))
(graphics-clear device)
(painter-a frame-a)
;; b.通过连接框架两对角画出一个大叉子的画家
(define painter-b
  (let ((O (make-vect 0 0))
	(A (make-vect 1 0))
	(B (make-vect 0 1))
	(C (make-vect 1 1)))
    (segments->painter (list (make-segment C O)
			     (make-segment A B)))))
(painter-b frame-a)
;; c.通过连接框架各边中点菱形的画家
(define painter-c
  (let ((E (make-vect .5 0))
	(F (make-vect 1 .5))
	(G (make-vect .5 1))
	(H (make-vect 0 .5)))
    (segments->painter (list (make-segment E F)
			     (make-segment F G)
			     (make-segment G H)
			     (make-segment H E)))))
(painter-c frame-a)
;; d.画家wave
(define wave
  (let ((A (make-vect .5 1))
	(B (make-vect 0 0))
	(C (make-vect .8 0))
	(D (make-vect .25 .5))
	(E (make-vect .75 .5)))
    (segments->painter (list (make-segment A B)
			     (make-segment A C)
			     (make-segment D E)))))
(wave frame-a)

;; ------------------------------------------------------------
;; 画家的变换和组合
;; transform-painter: 参数:画家`变换框架. 生成画家的信息
(define (transform-painter painter origin corner1 corner2)
  (lambda(frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
	(painter
	 (make-frame new-origin
		     (sub-vect (m corner1) new-origin)
		     (sub-vect (m corner2) new-origin)))))))
;; 水平反转
(define (flip-vert painter)
  (transform-painter painter
		     (make-vect .0 1)
		     (make-vect 1 1)
		     (make-vect .0 .0)))
(wave frame-a)
((flip-vert wave) frame-a)
;; 1/4
(define (shrink-to-upper-right painter)
  (transform-painter painter
		     (make-vect .5 .5)
		     (make-vect 1.0 .5)
		     (make-vect .5 1)))
((shrink-to-upper-right wave) frame-a)
;; 逆时针旋转90度
(define (rotate90 painter)
  (transform-painter painter
		     (make-vect 1 0)
		     (make-vect 1 1)
		     (make-vect 0 0)))
(graphics-clear device)
((rotate90 wave) frame-a)
;; 向中心收缩
(define (squash-inwards painter)
  (transform-painter painter
		     (make-vect 0 0)
		     (make-vect 0.65 0.35)
		     (make-vect 0.35 0.65)))
(graphics-clear device)
((squash-inwards wave) frame-a)
;; beside
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0)))
    (let ((paint-left
	   (transform-painter painter1
			      (make-vect 0 0)
			      split-point
			      (make-vect 0 1)))
	  (paint-right
	   (transform-painter painter2
			      split-point
			      (make-vect 1 0)
			      (make-vect .5 1))))
      (lambda (frame)
	(paint-left frame)
	(paint-right frame)))))
(graphics-clear device)
((beside wave wave) frame-a)
;; ------------------------------
;; ex2.50
(define (flip-horiz painter)
  (transform-painter painter
		     (make-vect 1 0)
		     (make-vect 0 0)
		     (make-vect 1 1)))
(graphics-clear device)
((flip-horiz wave) frame-a)
(define (rotate180 painter)
  (transform-painter painter
		     (make-vect 1 1)
		     (make-vect 0 1)
		     (make-vect 1 0)))
((rotate180 wave) frame-a)
(define (rotate270 painter)
  (transform-painter painter
		     (make-vect 0 1)
		     (make-vect 0 0)
		     (make-vect 1 1)))
((rotate270 wave) frame-a)
;; ------------------------------
;; ex2.51
(define (below painter1 painter2)
  (let ((split-point (make-vect 0 .5)))
    (let ((paint-below
	   (transform-painter painter1
			      (make-vect 0 0)
			      (make-vect 1 0)
			      split-point))
	  (paint-top
	   (transform-painter painter2
			      split-point
			      (make-vect 1 .5)
			      (make-vect 0 1))))
      (lambda(frame)
	(paint-below frame)
	(paint-top frame)))))
(graphics-clear device)
((below wave wave) frame-a)
