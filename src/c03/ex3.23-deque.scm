;; 构造 make-deque
;; 选择 front-deque`rear-deque
;; 谓词 empty-deque?
;; 改变 set-front-ptr`set-rear-ptr
;; 改变 front-insert-deque!`rear-insert-deque!`front-delete-deque!`rear-delete-deque!

(define (make-deque)
  (define (front-deque ...))
  (define (rear-deque ...))
  (define (set-front-ptr! ...))
  (define (set-rear-ptr! ...))

  (define (empty-deque? ...))
  (define (front-insert-deque! item)
    (let ((new-front-deque (cons item (front-deque item))))
      (cond ((empty-deque?)
	     (set-front-ptr! new-front-deque)
	     (set-rear-ptr! new-front-deque)
	     deque)
	    (else
	     (set-front-ptr! new-front-deque)
	     deque))))
  (define (front-delete-deque!)
    (cond ((empty-deque?)
	   (error "empty-deque"))
	  (else
	   (set-front-ptr! (cdr (front-deque)))
	   deque)))
  (define (rear-insert-deque! item)
    (let ((new-pair (cons item ())))
      (cond ((empty-deque?)
	     (set-front-ptr! new-pair)
	     (set-front-ptr! new-pair)
	     deque)
	    (else
	     (set-cdr! (rear-deque) new-pair)
	     (set-rear-ptr! new-pair)
	     deque))))
  (define (rear-delete-deque!)
