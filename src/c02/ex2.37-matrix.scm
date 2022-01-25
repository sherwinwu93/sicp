(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (accumulate op initial (cdr sequence)))))
;; accumulate-n与accumulate类似
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      ()
      (cons (accumulate op init (map car seqs))
	    (accumulate-n op init (map cdr seqs)))))


;; (list 1 2 3 4) (list 1 2 3 4)
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
;; ((1 2 3 4) (4 5 6 7) (6 7 8 9)) * (1 2 3 4)
(define (matrix-*-vector m v)
  (map (lambda(l)
	 (dot-product l v))
       m))
(define m (list (list 1 2 3 4)
		(list 4 5 6 7)))
(define v (list 1 2 3 4))
(matrix-*-vector m v)

;; ((11 12 13) (21 22 23))
;; ((11 21) (12 22) (13 23))
(define (transpose mat)
  (accumulate-n (lambda (x y)
		  (cons x y))
		()
		mat))
;;
;; Pij=$kMijNkj
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda(l)
	   (matrix-*-vector cols l))
	 m)))
(define w (list (list 1 2)
		(list 3 4)))
(matrix-*-matrix w w)
;; Vi数的序列,矩阵Mij为向量矩阵
;; ((1 2 3 4) (4 5 6 7) (6 7 8 9))
;; 返回ViWi的和
(dot-product v w)
;; 矩阵x向量乘法, 返回向量
(matrix-*-vector m v)
;; 矩阵x矩阵,返回矩阵
(matrix-*-matrix m n)
;; 逆转矩阵
(transpose m)
