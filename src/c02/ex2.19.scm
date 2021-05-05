;; 更换零钱传参
;; 重新定义first-denomination: 以list为传参,返回list的第一个值
;;         except-first-denomination: 以list为传参,返回list的cdr
;;         no-more?:以list为传参,判断list是否为空

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))
(cc 100 us-coins)
(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define (first-denomination list)
  (car list))
(define (except-first-denomination list)
  (cdr list))
(define (no-more? list)
  (null? list))
