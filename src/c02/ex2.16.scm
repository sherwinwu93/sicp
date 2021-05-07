;; 计算除法时,出现由于精度问题,不得不截断的情况.
;; 除法越多,中途偏移越多次,最后得到结果偏移就越大
;; 用有理数的乘法
;; 一切得益于,pair的闭包性
;; 区间算术: 表示法构造器用两个有理数, 提供打印方法有理数转小数
;;           重新定义+-*/
;;           校验串联公式
(load (absolute "c02/p55-rational-number.scm"))
(load (absolute "c02/p57-make-rat.scm"))
(define (make-interval l u)
  (cons l u))
(define (lower-bound i)
  (car i))
(define (upper-bound i)
  (cdr i))


(define (add-interval l u)
  (make-interval (add-rat (lower-bound l) (lower-bound u))
                 (add-rat (upper-bound l) (upper-bound u))))
(define (sub-interval l u)
  (add-interval l (sub-rat (make-rat 0) u)))
;; 只考虑正数
(define (mul-interval l u)
  (make-rat (mul-rat (lower-bound l) (lower-bound u))
            (mul-rat (upper-bound l) (upper-bound u))))
(define (div-interval l u)
  (let ((one (make-rat 1 1)))
    (mul-interval l
                  (make-rat (div-rat one (lower-bound u))
                            (div-rat one (upper-bound u))))))


;; par1
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

;; par2
(define (par2 r1 r2)
  (let ((one (make-interval (make-rat 1 1) (make-rat 1 1))))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define r1 (make-interval (make-rat 3 5) (make-rat 4 5)))
(define r2 (make-interval (make-rat 7 10) (make-rat 9 10)))
(par1 r1 r2)
(par2 r1 r2)
