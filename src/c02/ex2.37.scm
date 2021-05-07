(load (absolute "c02/ex2.36.scm"))
;; dot-product:点的积,返回和[iViWi;
;; v,w:向量
(define v (list 1 2 3 4))
(define w (list 4 5 6 7))

(define (dot-product v w)
  (accumulate +
              0
              (map * v w)))

(dot-product v w)
;; matrix-*-vector:返回向量t,其中Ti=[iMijVj; 矩阵乘向量,返回向量
(define m (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
(define (matrix-*-vector m v)
  (map (lambda(subm)
         (dot-product subm v)) m))

(matrix-*-vector m v)
;; matrix-*-matrix:返回矩阵p,其中Pij=[iMikMkj; 矩阵乘矩阵,返回矩阵
(define A (list (list 3 1 2) (list -2 0 5)))
(define B (list (list -1 3) (list 0 5) (list 2 5)))
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda(subm)
           (matrix-*-vector cols subm))
         m)))

(matrix-*-matrix a b)
;; transpose: 返回矩阵n,其中Nij=Mji; 逆转矩阵
(define (transpose mat)
  (accumulate-n cons
                ()
                mat))
(transpose m)
