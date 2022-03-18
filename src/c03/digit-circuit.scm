;; ------------------------------------------------------------ 3.3.4 数字电路的模拟器
;; 对电路设计做计算机模拟.
;; 事件驱动的模拟.多米洛骨牌

;; 连线: 数字信号: 0或1
;; 基本功能块: 非门 与门 或门

;; 基本元素
;; 构造6根连线
(define a (make-wire))
(define b (make-wire))
(define c (make-wire))
(define d (make-wire))
(define e (make-wire))
(define s (make-wire))
;; 组合起来
;; half-adder
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

;; ------------------------------------------------------------ 基本功能块
;; (get-signal wire)
;; (set-signal wire new-value)
;; (add-action! <wire> <procedure of no arguments>): 只要连线上信号改变,指定过程就需要运行
;; (after-delay ...)
(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
		   (lambda()
		     (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)
(define (logical-not s)
  (cond ((= s 0) 1)
	((= s 1) 0)
	(else (error "Invalid signal" s))))
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
	   (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
		   (lambda()
		     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)
(define (logical-and a1 a2)
  (cond ((and (= a1 1) (= a2 1))
	 1)
	(else 0)))

;; ------------------------------ ex3.28
;; or-gate
(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value
	   (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
		   (lambda()
		     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)
(define (logical-or a1 a2)
  (cond ((or (= a1 1) (= a2 1))
	 a1)
	(else 0)))

;; ------------------------------ ex3.29
;; 用and-gate-delay和inverter-delay构造出or-gate
(define (or-gate a1 a2 output)
  (let ((i1 (make-wire))
	(i2 (make-wire))
	(s (make-wire)))
    (inverter a1 i1)
    (inverter a2 i2)
    (and-gate i1 i2 s)
    (inverter s output)
    'ok))
;; 延时 inverter-delay * 2 + and-gate-delay
;; ------------------------------ ex3.30
(define (cascade-carry-adder list-a list-b c list-c list-s)
  (if (null? list-a)
      'done
      (let ((An (car list-a))
	    (Bn (car list-b))
	    (Sn (car list-s))
	    (Cn (car list-c)))
	(full-adder An Bn C Sn Cn)
	(cascade-carry-adder (cdr list-a) (cdr list-b) Cn (cdr list-s)))))
;; 先计算出half-adder
;; Dhalf-adder = Dor + Dand 或者 2* Dand + Dnot
;; 再计算出full-adder
;; Dfull-adder = 2*Dhalf-adder + Dnot
;; 那么级联
;; n * Dfull-adder =
;; 2nDor + 2nDand + nDnot 或 4nDand + 3nDnot

;; ------------------------------ 线路的表示
(define (make-wire)
  (let ((signal-value 0) (action-procedures ()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
	  (begin (set! signal-value new-value)
		 (call-each action-procedures))
	  'done))
    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      ;; 事件驱动模拟
      (proc))
    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
	    ((eq? m 'set-signal!) set-my-signal!)
	    ((eq? m 'add-action!) accept-action-procedure!)
	    (else (error "unknown operation -- WIRE" m))))
    dispatch))
(define (call-each procedures)
  (if (null? procedures)
      'done
      (begin
	((car procedures))
	(call-each (cdr procedures)))))
(define (get-signal wire)
  (wire 'get-signal))
(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))
(define (add-action! wire action-procedures)
  ((wire 'add-action!) action-procedures))
;; 线路有随时间变化的信号,并且链接到个各种设备上,因此是典型的变动对象

;; ------------------------------------------------------------ 带处理表
;; agenda的数据抽象
;; (make-agenda)
;; (empty-agenda? agenda)
;; (first-agenda-item agenda) 返回待处理表的第一个项目
;; (remove-first-agenda-item! agenda) 删除待处理表的第一个项目
;; (add-to-agenda! time action agenda) 加入代处理表一个项目,并要求特定时间执行过程
;; (current-time agenda) 当时的模拟时间
(define (after-delay delay action)
  (add-to-agenda! (+ delay (current-time the-agenda))
		  action
		  the-agenda))
;; progate驱动模拟,对the-agenda操纵,顺序执行表中每个过程
(define (propagate)
  (if (empty-agenda? the-agenda)
      'done
      (let ((first-item (first-agenda-item the-agenda)))
	(first-item)
	(remove-first-agenda-item! the-agenda)
	(propagate))))

(define (probe name wire)
  (add-action! wire
	       (lambda()
		 (newline)
		 (display name)
		 (display " ")
		 (display (current-time the-agenda))
		 (display " new-value = ")
		 (display (get-signal wire)))))

;; 初始化agenda和确定功能块的延时
(define the-agenda (make-agenda))
(define invert-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

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

;; ------------------------------ ex3.31
;; -- 如果不模拟action-procedure,会出现什么情况
(define (accept-action-procedure! proc)
  (set! action-procedures (cons proc action-procedures)))


;; ------------------------------------------------------------ 待处理表的实现
;; time-segment
(define (make-time-segment time queue)
  (cons time queue))
(define (segment-time s) (car s))
(define (segment-queue s) (cdr s))

(define (make-agenda) (list 0))
(define (current-time agenda) (car agenda))
(define (set-current-time! agenda time)
  (set-car! agenda time))
(define (segments agenda) (cdr agenda))
(define (set-segments! agenda segments)
  (set-cdr! agenda segments))
(define (first-segment agenda) (car (segments agenda)))
(define (rest-segment agenda) (cdr (segments agenda)))

(define (empty-agenda? agenda)
  (null? (segments agenda)))

(define (add-to-agenda! time action agenda)
  (define (belongs-before? segments)
    (or (null? segments)
	(< time (segment-time (car segments)))))
  (define (make-new-time-segment time action)
    (let ((q (make-queue)))
      (insert-queue! q action)
      (make-time-segment time q)))
  (define (add-to-segments! segments)
    (if (= (segment-time (car segments)) time)
	(insert-queue! (segment-queue (car segments))
		       action)
	(let ((rest (cdr segments)))
	  (if (belongs-before? rest)
	      (set-cdr!
	       segments
	       (cons (make-new-time-segment time action)
		     (cdr segments)))
	      (add-to-segments! rest)))))
  (let ((segments (segments agenda)))
    (if (belongs-before? segments)
	(set-segments!
	 agenda
	 (cons (make-new-time-segment time action)
	       segments))
	(add-to-segments! segments))))

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
	(set-segments! agenda (rest-segments agenda)))))

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda is empty -- FIRST-AGENDA-ITEM")
      (let ((first-seg (first-segment agenda)))
	(set-current-time! agenda (segment-time first-seg))
	(front-queue (segment-queue first-seg)))))
