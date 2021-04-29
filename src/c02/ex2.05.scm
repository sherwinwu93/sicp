(load "../c01/p30-fast-expt.scm")
;; 将a和b的pair表示为2^a*3^b的整数s
;; 因为2与3互质,所以s的必然有a个2,b个3
;; 证明可行性
(define p (cons 3 4))
;; 3
(car p)
;; 4
(cdr p)
(define (cons a b)
  (* (fast-expt 2 a) (fast-expt 3 b)))
;;
(define (car s)
  (if (not (= (remainder s 2) 0))
      0
      (1+ (car (/ s 2)))))
;;
(define (cdr s)
  (if (not (= (remainder s 3) 0))
      0
      (1+ (cdr (/ s 3)))))
