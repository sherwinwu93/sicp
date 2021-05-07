;; 定义过程,返回所有<=整数n的正的相异整数i`j和k的三元组,使每个三元组之和等于给定的整数s
(define (equal-s triad s)
  (= s (+ (car triad) (cadr triad) (cadr (cdr triad)))))
(define (unique-pairs n)
  (flatmap (lambda(i)
             (map (lambda(j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))
(unique-pairs 5)

(define (triad unique-pairs)
  (flatmap (lambda(unique-pair)
             (map (lambda(i) (append unique-pair (list i)))
                  (enumerate-interval 1 (- (cadr unique-pair) 1))))
       (filter (lambda(unique-pair) (not (= (cadr unique-pair) 1)))
               unique-pairs)))


(define (equal-s-sum-triad n s)
  (define (equal-s triad)
    (= s (+ (car triad) (cadr triad) (cadr (cdr triad)))))
  (filter equal-s
          (triad (unique-pairs n))))

(equal-s-sum-triad 5 8)
