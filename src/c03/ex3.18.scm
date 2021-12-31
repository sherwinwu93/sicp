;; 定义过程:检查表,确定是否包含环.
(define (cycle? x)
  (define first-pointer x)
  (define (inner x)
    (if (null? x)
        false
        (if (eq? x first-pointer)
            true
            (inner (cdr x)))))
  (if (or (null? x) (null? (cdr x)))
      false
      (inner (cdr x))))
(define z (make-cycle (list 'a 'b)))
(cycle? z)
(cycle? (list 'a 'b))

;; 检查列表是否有环
;; 1. 设置唯一标识符
;; 2. 遍历列表,使用eq?检查每个序对的car部分是否和identity相等,相等的话,有环,不相等,car部分设置为identity,然后继续遍历列表的cdr部分,直到发现环或者列表为空为止
(define (loop? lst)
  (let ((identity (cons () ())))

    (define (iter remain-list)
      (cond ((null? remain-list) false)
            ((eq? identity (car remain-list)))
            ((set-car! remain-list identity)
             (iter (cdr remain-list)))))
    (iter lst)))
