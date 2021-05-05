;; 写出过程last-pair
;;                  :返回表里最后一个元素的表
(my-last-pair (list 23 72 149 34))

(define (my-last-pair list)
  (if (null? (cdr list))
      (car list)
      (my-last-pair (cdr list))))

;; 修正, 必须了解所有情况
(define (my-last-pair lst)
  (cond ((null? lst)
         (error "list empty --LAST-PAIR"))
        ((null? (cdr lst)) lst)
        (else
         (my-last-pair (cdr lst)))))
