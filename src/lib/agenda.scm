(load-r "c03/p180-queue.scm")
;; ------------------------------------------------------------ 待处理表的实现
;; agenda的数据抽象
;; (make-agenda)
;; (empty-agenda? agenda)
;; (first-agenda-item agenda) 返回待处理表的第一个项目
;; (remove-first-agenda-item! agenda) 删除待处理表的第一个项目
;; (add-to-agenda! time action agenda) 加入代处理表一个项目,并要求特定时间执行过程
;; (current-time agenda) 当时的模拟时间
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
(define (rest-segments agenda) (cdr (segments agenda)))

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

(define a2 (make-agenda))
(empty-agenda? a2)
;; (first-agenda-item a2)
;; (remove-first-agenda-item! a2)
;; (define (action1) 'act1)
;; (define (action2) 'act2)
;; (define (action3) 'act3)
;; (add-to-agenda! 1 action1 a2)
;; (add-to-agenda! 1 action2 a2)
;; (add-to-agenda! 2 action3 a2)
