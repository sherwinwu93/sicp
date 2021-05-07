(load-r "c02/p83-flatmap.scm")

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (lambda(i)
                  (map (lambda(j) (list i j))
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 n)))))
;; 定义过程unique-pairs,传参n:整数,返回序对(i,j),其中1<=j<i<=n.用unique-pairs去简化prime-sum-pairs
(define (unique-pairs n)
  (flatmap
   (lambda(i)
     (map (lambda(j) (list i j))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))
;; 用来简化prime-sum-pairs
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))
(prime-sum-pairs 6)
