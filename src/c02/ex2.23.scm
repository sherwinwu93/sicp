;; for-each用于执行某些动作的过程
(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))
;; 给出foreach的实现
;; 使用begin绑定多条表达式为一条表达式
;; cond隐含begin
(define (foreach procedure lst)
  (if (null? lst)
      true
      (begin (procedure (car lst))
       (for-each procedure (cdr lst)))))
(define (foreach procedure lst)
  (cond ((null? lst) true)
        (else (procedure (car lst))
              (for-each procedure (cdr lst)))))
(foreach (lambda (x) (newline) (display x))
         (list 57 321 88))

