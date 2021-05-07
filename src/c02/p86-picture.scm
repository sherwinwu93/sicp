#lang sicp
(#%require sicp-pict)

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
