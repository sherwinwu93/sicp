;; 数据标志
;; 自动拆装包
(define (attach-tag type-tag contents)
  (if (equal? type-tag 'scheme-number)
      contents
      (cons type-tag contents)))
(define (type-tag datum)
  (if (pair? datum)
      (if (symbol? (car datum))
          (car datum)
          'list)
      'scheme-number))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      datum))
