;; 图形语言
;; 某些元素重复出现,元素可以变形或者改变大小
;; 基本元素: 给定矩形,画出对应的图形
;; 组合: beside above
;; 抽象:
(define wave2
  ;; flip-vert 垂直翻转
  ;; beside 水平合并
  (beside wave (flip-vert wave)))

(define wave4
  (below wave2 wave2))
;; closure: 两个画家的beside或below还是画家

;; 抽象wave4
(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))
(define wave4 (flipped-pairs wave))

;;
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
	(beside painter (below smaller smaller)))))
;; ex2.44
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

;; 高级操作
;; 把画家操作看成是操作和描写这些元素的组合方法的元素
;; 写出以画家操作为参数,创建各种新的画家操作
;; 高阶过程定义square-of-four 使用painter为基本元素
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

;; ex2.45 对right-split和up-split进行抽象
(define (split op1 op2)
  (lambda(painter)
    (op1 painter
	 (op2 painter painter))))

(define right-split (split beside below))
(define up-split (split below beside))

;; 框架
