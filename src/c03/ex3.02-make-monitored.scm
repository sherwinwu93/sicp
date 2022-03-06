;; 计算过程中某个给定过程被调用的次数
;; 写出过程make-monitored
;;   以f为输入,
;;   过程本身有输入
;;   返回第三个过程mf
;;   用内部计数器调用次数
;;   mf的参数是how-many-calls?,返回内部计数器的值
;;   mf的参数是reset-count,计数器重置
;;   对于其他输入,将f应用于这一输入的结果,并将计数器加一
(define (make-monitored f)
  (let ((N 0))
    (define (mf arg)
      (cond ((eq? 'how-many-calls? arg) N)
	    ((eq? 'reset-count arg)
	     (begin (set! N 0)
		    N))
	    (else (begin (set! N 1)
			 (f arg)))))
    mf))

(define s (make-monitored sqrt))

(s 100)
10
(s 'how-many-calls?)
1
