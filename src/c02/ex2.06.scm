;; 完全抽象构造数字!!!
;; Church计数, 丘奇计数,lambda演算也是他发明的
;; 定义0
(define zero (lambda(a0) (lambda(b0) b0)))
;; 定义加1
(define (add-1 n)
  (lambda(a) (lambda(b) (a ((n a) b)))))
;; 直接定义one和two
;; one=(add-1 zero)的代换模型
(add-1 zero)
(lambda(a1) (lambda(b1) (a1 ((
                              (lambda(a0) (lambda(b0) b0))
                              b1) b1))))
(lambda(a1) (lambda(b1) (a1 (
                             (lambda(b0) b0)
                             b1))))
(lambda(a1) (lambda(b1) (a1
                         b1
                         )))
(lambda(a1) (lambda(b1) (a1 b1)))
;; 纠正two
(add-1 one)
(lambda(a2) (lambda(b2) (a2 ((one a2) b2))))
(lambda(a2) (lambda(b2) (a2 ((
                              (lambda(a1) (lambda(b1) (a1 b1)))
                              a2) b2))))
(lambda(a2) (lambda(b2) (a2 (
                             (lambda(b1) (b2 b1))
                             a2))))
(lambda(a2) (lambda(b2) (a2
                         (a2 b2)
                         ))
(lambda(a2) (lambda(b2) (a2
                         (a2 b2)
                         )))
;; 由此+的过程很容易定义出
(define (+ n1 n2)
  (lambda(f)
    (lambda(x)
     ((n1 f) ((n2 f) x)))))

;; one + one
(+ one one)
(+ (lambda(f) ((lambda(x) (f x))))
   (lambda(f) ((lambda(x) (f x)))))
(lambda(f)
  (lambda(x)
    ((
      (lambda(f) ((lambda(x) (f x)))
             f) ((
                  (lambda(f) ((lambda(x) (f x)))
                         f) x))))))
(lambda(f)
  (lambda(x)
    ((
      (lambda(x) (f x))
      ((
        (lambda(x) (f x))
        x))))))
(lambda(f)
  (lambda(x)
    ((
      (lambda(x) (f x))
      (f x)))))

(lambda(f)
  (lambda(x)
    (f (f x))
    ))
