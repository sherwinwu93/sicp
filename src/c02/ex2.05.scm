;; 用2^a*3^b定义cons,car,cdr
(load-r "lib/math.scm")

(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (car x)
  (if (not (= (remainder x 2) 0))
      0
      (1+ (car (/ x 2)))))

(define (cdr x)
  (if (not (= (remainder x 3) 0))
      0
      (1+ (car (/ x 3)))))

(cdr (cons 2 3))
