;; 写出过程last-pair
;;                  :返回表里最后一个元素的表
(my-last-pair (list 23 72 149 34))

(define (my-last-pair list)
  (if (null? (cdr list))
      (car list)
      (my-last-pair (cdr list))))
