(load-r "c02/ex2.69.scm")
(load-r "c02/ex2.68.scm")
;; 编码摇滚歌曲:
;;  A 2 NA 16
;;  BOOM 1 SHA 3
;;  GET 1 YIP 9
;;  JOB 2 WAH 1
;; 用ex2.69generate-huffman-tree生成huffman树,用ex2.68encode编码下面消息
GET A JOB
SHA na na na na na na na na
GET a job
SHA na na na na na na na na
Wah yip yip yip yip yip yip yip yip yip
Sha boom
;; 需要多少个二进制位?84
(define music-huffman-tree
  (generate-huffman-tree
   '((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 1) (YIP 9) (JOB 2) (WAH 1))))
(define music-message '(GET A JOB SHA na na na na na na na na GET a job SHA na na na na na na na na Wah yip yip yip yip yip yip yip yip yip Sha boom))
;; 84
(length (encode music-message music-huffman-tree))
(length music-message)
;; 如果用定长编码,要多少个二进制位?108
(* 36 3)
