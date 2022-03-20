;; 对电路设计做计算机模拟.
;; 事件驱动的模拟.多米洛骨牌

;; 连线: 数字信号: 0或1
;; 基本功能块: 非门 与门 或门

;; 基本元素
;; 构造6根连线
(load-r "c03/p192-make-wire.scm")
(define a (make-wire))
(define b (make-wire))
(define c (make-wire))
(define d (make-wire))
(define e (make-wire))
(define s (make-wire))
;; 组合起来
;; half-adder
(load-r "c03/gate.scm")
(or-gate a b d)
(and-gate a b c)
(inverter c e)
(and-gate d e s)
;; 抽象起来
(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))
;; 定义全加器 黑盒抽象
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
	(c1 (make-wire))
	(c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

;; 定义4条线路, 两条线路安装监测器
(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

;; =>sum 0 new-value = 0
(probe 'sum sum)
;; =>carry 0 new-value = 0
(probe 'carry carry)

;; =>ok
(half-adder input-1 input-2 sum carry)

(set-signal! input-1 1)

;; =>sum 8 new-value = 1
;; done
(propagate)

;; =>done
(set-signal! input-2 1)

;; =>carry 11 new-value=1
;;  sum 16 new-value=0
;; done
(propagate)

(define a1 (make-wire))
(define a2 (make-wire))
(define sum (make-wire))
(and-gate a1 a2 sum)
(probe 'a1 a1)
(probe 'a2 a2)
(probe 'sum sum)

(set-signal! a1 0)
(set-signal! a2 1)

(set-signal! a1 1)
(set-signal! a2 0)
