;; 定义unique-pairs,给整数n,产生(i,j)
;; 再用unique-pairs简化prime-sum-pairs定义
(load-r "c02/p83-flatmap.scm")
(define (unique-pairs n)
  (flatmap
   (lambda(i)
     (map (lambda(j) (list i j))
	  (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))
;; 枚举, 过滤, 映射
(define (prime-sum-pairs n)
  (map make-pair-sum (filter prime-sum? (unique-pairs n))))
(prime-sum-pairs 6)
