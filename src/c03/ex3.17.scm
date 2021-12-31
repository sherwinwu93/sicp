(load-r "c03/p177-share.scm")
;; 设计3.16的count-pairs过程的正确版本,对任何结构都正确返回不同序对的个数
;; (define (count-pairs x)
;;   (define (pair-exits? lst x)
;;     (if (null? lst)
;;         false
;;         (if (eq? lst x)
;;             true
;;             (pair-exits? (cdr lst) x))))
;;   (define (count-pairs x exits-pairs)
;;     (if (not (pair? x))
;;         0
;;         (+ (count-pairs (car x))
;;            (count-pairs (cdr x))
;;            (if (pair-exits? exits-pairs x)
;;                1
;;                (exits-append! exits-pairs x)))))
;;   (define (exits-append! exits-pairs x)
;;     (append! x exits-pairs)
;;     0)
;;   (count-pairs x ()))

;; (memq x list): x是否在list中
(define (count-pairs x)
  (length (inner x '())))
;; 如果是pair且不在已记录的list里面,那么返回计算(inner 第一个值 计算出剩下的值)
;;                                  否则就返回已记录的list
(define (inner x memo-list)
  (if (and (pair? x)
           (false? (memq x memo-list)))
      (inner (cdr x)
             (cons x memo-list))
      memo-list))
(define x (cons 'a 'b))
(define y (cons x x))
(define z (cons y y))
(count-pairs z)
