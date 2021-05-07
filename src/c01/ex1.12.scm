(define (pascal row line)
  (cond ((= line 1)1)
	((= line row) 1)
	((= row 1) 1)
	(else (+ (pascal (- row 1) (- line 1))
		 (pascal (- row 1) line)))))
;;帕斯卡三角形,树形递归计算过程
(define (pascal row line)
  (if (or (= line 1) (= line row) (= row 1))
      1
      (+ (pascal (- row 1) (- line 1))
	 (pascal (- row 1) line))))

(pascal 5 4)

;; 迭代计算过程, 帕斯卡另一公式(row line)=row!/ (line!(row-line)!)
;; 意义不大
(load (absolute "c01/p15-factorial.scm"))
(define (pascal row line)
  (/ (factorial (- row 1))
     (* (factorial (- line 1))
	(factorial (- row line)))))
(pascal 5 4)
  
