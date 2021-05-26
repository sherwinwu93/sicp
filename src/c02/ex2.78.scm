(load-r "c02/p129-generic-operator.scm")
;; 使用symbol? number?确定是否有特定的类型
;; 修改type-tag`contents`attach-tag定义,使用通用算术系统可以利用Scheme内部类型系统
;; 即实现: (add 1 2) => 3

;; type-tag是'scheme-number时,返回contents
(define (attach-tag type-tag contents)
  (if (eq? 'scheme-number type-tag)
      contents
      (cons type-tag contents)))
;; 如果datum是number时,直接返回'scheme-number
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (if (number? datum)
          'scheme-number
          (error "Bad tagged datum -- TYPE-TAG" datum))))
;; 如果datum是number时,直接返回其自身
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (if (number? datum)
          datum
          (error "Bad tagged datum -- CONTENTS" datum))))
(add 1 2)
(sub 1 2)
