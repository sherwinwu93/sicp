(define (cube x)
  (* x x x))

(define (p x)
  (- (* 3 x)
     (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

;; a.(sine 12.15) 求值多少次 5次o
(trace p)

(sine 12.15)
(p (sine 4.05))
(p (p (sine 1.35)))
(p (p (p (sine 0.45))))
(p (p (p (p (sine 0.15)))))
(p (p (p (p (p (sine 0.05))))))
(p (p (p (p (p 0.05)))))
(p (p (p (p 0.1495))))
(p (p (p 0.435134)))
(p (p .97584))
(p -.7895)
-0.4

;; b.
;; 增大三倍,p的运行次数增加一次,所以时间和空间复杂度都是O(log a)
time: O(log a)
space: O(log a)

;; 由此看来,不能计算过程的形状只能帮助我们计算时间`空间复杂度,计算时间空间复杂度只有一种方式
;; 就是看问题规模增大多少,对应所需资源量增大多少
