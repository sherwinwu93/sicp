(define (hanoi disks from to buffer)
 (if (= disks 1)
  (list (cons from to))
  (let ((s (hanoi (- disks 1) from buffer to)))
   (append
    s
    (list (cons from to))
    (map
     (lambda (x)
      (let ((f (lambda (y) (cond ((= y from) buffer) ((= y buffer) to) (else from)))))
	(cons (f (car x)) (f (cdr x))))) s)))))
(hanoi 4 1 2 3)

(define (hanoi disks from to buffer)
  (if (= disks 1)
      ;; 键值对 car:from cdr:to
      (list (cons from to))
      ;; 绑定(hanoi (- disks 1) from buffer to) 到s
      (let ((s (hanoi (- disks 1) from buffer to)))
	;; 执行具体操作
	;; 执行s:即(hanoi (- disks 1) from buffer to)
	;; 打印from, to
	;; 替换s 的传参from->buffer buffer->to to->from,并执行
	(append
	 s
	 (list (cons from to))
	 (map
	  ;; x是hanoi的传参?
	  (lambda (x)
	    (let ((f (lambda (y) (cond ((= y from) buffer) ((= y buffer) to) (else from)))))
	    	      (cons (f (car x)) (f (cdr x)))))
	  s)))))
(hanoi 4 5 6 7)

(list 1)
(car (cons 1 2))

