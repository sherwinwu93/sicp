;; cons 练习1
1. ("hi" . "everybody")
(cons "hi" "everybody")
2. (0)
(cons 0 '())
3. (1 10 . 100)
(cons 1 (cons 10 100))
4. (1 10 100)
(cons 1 (cons 10 (cons 100 '())))
5. (#\I "saw" 3 "girls")
(cons #\I (cons "saw" (cons 3 (cons "girls" '()))))
6. ("Sum of" (1 2 3 4) "is" 10)
(cons "Sum of" (cons (cons 1 (cons 2 (cons 3 (cons 4 '())))) (cons "is" (cons 10 '()))))

;; cons 练习2
1. (car '(0))
0
2. (cdr '(0))
()
3. (car '((1 2 3) (4 5 6)))
(1 2 3)
4. (cdr '(1 2 3 . 4))
(2 3 . 4)
5. (cdr (cons 3 (cons 2(cons 1'()))))
(2 1)

;; define 练习1
1. 将参数+1的函数
2. 将参数-1的函数
;; define 练习2
让我们按照下面的步骤编写一个用于计算飞行距离的函数。

1. 编写一个将角的单位由度转换为弧度的函数。180度即π弧度。π可以通过下面的式子定义：
(define pi (* 4 (atan 1.0))).

2. 编写一个用于计算按照一个常量速度（水平分速度）运动的物体，t秒内的位移的函数。


3. 编写一个用于计算物体落地前的飞行时间的函数，参数是垂直分速度。忽略空气阻力并取重力加速度g为9.8m/s^2。提示：设落地时瞬时竖直分速度为-Vy，有如下关系。2 * Vy = g * t此处t为落地时的时间。


4.使用问题1-3中定义的函数编写一个用于计算一个以初速度v和角度theta掷出的小球的飞行距离。
(define g 9.8)
(define pi (* 4 (atan 1.0)))

(define (fly-distance v theta)
  (* (fly-time v theta) (v-x v theta)))

(define (fly-time v theta)
  (/ (* 2 (v-y v theta)) g))

(define (v-y v theta)
  (* v (sin (radian theta))))
(v-y 30 40)

(define (radian theta)
  (exact->inexact (/ (* theta PI) 180)))

(define (v-x v theta)
  (* v (cos  (radian theta))))

(fly-distance 40 30)



5.计算一个初速度为40m/s、与水平方向呈30°的小球飞行距离。这个差不多就是一个臂力强劲的职业棒球手的投掷距离。


;; 测试正则序和应用序
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

(null? '())
;; 分支 练习1
编写下面的函数。阅读第五节了解如何编写谓词。

1. 返回一个实数绝对值的函数。
(define (abs x)
  (if (> x 0)
      x
      (- x)))
(abs 1)
(abs 0)
(abs -1)
	    
2. 返回一个实数的倒数的函数。如果参数为0，则返回#f。
(define (reciprocal x)
  (if (= x 0)
      #f
      (/ 1.0 x)))
(reciprocal 1)
(reciprocal 2)
(reciprocal .5)
(reciprocal 0)

3. 将一个整数转化为ASCII码字符的函数。只有在33~126之间的ASCII码才能转换为可见的字符。使用integer->char可以将整数转化为字符。如果给定的整数不能够转化为字符，那么就返回#f
(define (integer-ascii i)
  (if (and (> i 33) (< i 126))
      (integer->char i)
      #f))
(integer-ascii 125)

(and #f 0)

;; 分支 练习3
(define (mapToU score)
  (cond ((or (> score 80) (= score 80)) "A")
	((and (>= score 60) (<= score 79)) "B")
	((and (>= score 40) (<= score 59)) "C")
	((< score 40) "D")))
(mapToU 80)
(mapToU 79)
(mapToU 40)
(mapToU 39)
(mapToU 79.5) -> Unspecified return value

- eq
(define str "hello") 

(eq? str str) #t

(eq? "hello" "hello") #f

;; 比较数字依赖具体实现
(eq? 1 1)

(eq? 1.0 1.0)

- eqv?
(eqv? 1.0 1.0)

(eqv? 1 1.0) #f:因为类型不一样
;;不适合用来比较序列
(eqv? (list 1 2 3) (list 1 2 3))

(eqv? "hello" "hello")

(eqv? (lambda(x) x) (lambda(x) x))

- equal?
(equal? (list 1 2 3) (list 1 2 3))

(equal? 1 1)

;; 重复 练习1
用递归编写下面的函数。

1. 用于统计表中元素个数的my-length函数。（length是一个预定义函数）。
(define (my-length ls)
  (if (null? ls)
      0
      (1+ (my-length (cdr ls)))))
(my-length '(0 1 2))

2. 一个求和表中元素的函数。
(define (sum-iter ls product)
  (if (null? ls)
      product
      (sum-iter (cdr ls) (+ product (car ls)))))
(define (sum ls)
  (sum-iter ls 0))
(sum '(0 2 4))


3. 一个分别接受一个表ls和一个对象x的函数，该函数返回从ls中删除x后得到的表。
(define (remove ls x)
  (cond ((null? ls) '())
	((equal? (car ls) x) (cons (car (cdr ls)) (remove (cdr (cdr ls)) x)))
	(else (cons (car ls) (remove (cdr ls) x)))))
(remove '(0 2 4) 2)
      
4. 一个分别接受一个表ls和一个对象x的函数，该函数返回x在ls中首次出现的位置。索引从0开始。如果x不在ls中，函数返回#f。
(define (my-index ls x)
  (my-index-iter ls x 0))
(define (my-index-iter ls x i)
  (cond ((null? ls) #f)
	((equal? (car ls) x) i)
	(else (my-index-iter (cdr ls) x (+ i 1)))))

(my-index '(0 2 4 3) 3)
