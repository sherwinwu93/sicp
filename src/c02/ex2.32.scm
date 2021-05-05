;; 所有排列组合:subsets
;;            例如: (1 2 3)->() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)
(define (subsets s)
  (if (null? s)
      (list ())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda(subrest)
                            (cons (car s) subrest))
                          rest)))))

(subsets (list 1 2 3))

;; 1 2 3被分为有1的rest0和没1的rest1.其中rest0=对rest1的每一个增加元素1
;; 原问题分解为子问题,并且子问题不停地缩小规模,到null时是最简单的情况
;; 符合递归法则
