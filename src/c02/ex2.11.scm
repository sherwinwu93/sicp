;; 通过监测区间,mul-interval分为9种清空,每种情况所需乘法不超过2次
;; 重写该过程
(load "ex2.08.scm")

;; 原区间乘法
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
(define (min x y)
  (if (< x y)
      x
      y))
(define (max x y)
  (if (> x y)
      x
      y))
;; 改良后区间乘法
(define (mul-interval x y)
  (let ((xl (lower-bound x))
        (xu (upper-bound x))
        (yl (lower-bound y))
        (yu (upper-bound y)))
    (cond ((and (< xu 0) (< yu 0)) (make-interval (* xu yu)
                                                  (* xl yl)))
          ((and (< xu 0) (and (<= yl 0) (>= yu 0))) (make-interval (* xl yu)
                                                                   (* xl yl)))
          ((and (< xu 0) (> yl 0) (make-interval (* xl yu)
                                                 (* xu yu))))
          ((and (and (<= xl 0) (>= xu 0)) (< yl 0)) (make-interval (* xu yl)
                                                                   (* xl yl)))
          ((and (and (<= xl 0) (>= xu 0)) (and (<= yl 0) (>= yu 0)))
           (make-interval (min (* xl yu)
                               (* xu yl))
                          (max (* xl yl)
                               (* xu yu))))
          ((and (and (<= xl 0) (>= xu 0)) (> yl 0)) (make-interval (* xl yu)
                                                                   (* xu yl)))
          ((and (> xl 0) (< yl 0)) (make-interval (* xu yl)
                                                  (* xl yu)))
          ((and (> xl 0) (and (<= yl 0) (>= yu 0))) (make-interval (* xu yl)
                                                                   (* xu yu)))
          ((and (> xl 0) (> yl 0) (make-interval (* xl yl)
                                                 (* xu yu)))))))

(define x1 (make-interval -2 -1))
(define x2 (make-interval -1 1))
(define x3 (make-interval 1 2))

(define y1 (make-interval -2 -1))
(define y2 (make-interval -1 1))
(define y3 (make-interval 1 2))
(mul-interval x1 y1)
(mul-interval x1 y2)
(mul-interval x1 y3)
(mul-interval x2 y1)
(mul-interval x2 y2)
(mul-interval x2 y3)
(mul-interval x3 y1)
(mul-interval x3 y2)
(mul-interval x3 y3)

;; 处理中间值和一个附加误差的形式
;; 希望程序处理3.5+-0.15,而不是[3.35, 3.65]
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
;; 3.35, 3.65
(define i (make-center-width 3.5 0.15))
;; 3.5
(center i)
;; 0.15
(width i)
