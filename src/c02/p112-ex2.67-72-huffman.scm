;; ------------------------------------------------------------ 实例:Huffman编码树
;; 编码:用0和1的序列表示数据的方法
;;   eg: A 000 B 001 C 010 D 011 E 100 F 101 G 110 H 1111
;;   定长编码和变长编码(长度会改变)
;;   eg: A 0 B 100 C 1010 D 1011 E 1100 F 1101 G 1110 H 1111
;;   变长编码的优点: 节省空间
;;   变长编码的困难: 何时到达字符结束
;;          困难解决: 1. 特殊分隔符(莫尔斯码) 2. 某种方式设计编码,使得每个字符的完整编码都是另一编码的前缀(前缀码) Huffman(David Huffman)

;; Huffman编码: 表示为二叉树,树叶是被编码的符号.每个非叶结点代表集合(包含这一结点下所有树叶的符号,除此外还有权重)
;;        编码: 往左行加0,往右行加1

;; ------------------------------------------------------------ Huffman树的表示
;; 树叶表示为 (list 'leaf 叶中符号 权重)
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

;; 树的表示 由左右分支构造, 生成 left+right+(left的符号集合+right的符合集合)+(left的权重+right的权重)
(define (make-code-tree left right)
  (list left
	right
	(append (symbols left) (symbols right))
	(+ (weight left) (weight right))))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cdr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

;; ------------------------------------------------------------ 解码过程
(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
	()
	(let ((next-branch
	       (choose-branch (car bits) current-branch)))
	  (if (leaf? next-branch)
	      (cons (symbol-leaf next-branch)
		    (decode-1 (cdr bits) tree))
	      (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
	((= bit 1) (right-branch branch))
	(else (error "bad bit -- CHOOSE-BRANCH" bit))))
;; ------------------------------------------------------------ 带权重元素的集合
;; 带权重的元素集合添加过程: 按权重大小顺序排序
;;   eg: ((A 4) (B 2) (C 1) (D 1))
(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((< (weight x) (weight (car set))) (cons x set))
	(else (cons (car set)
		    (adjoin-set x (cdr set))))))
;; 构造树叶的初始排序集合
(define (make-leaf-set pairs)
  (if (null? pairs)
      ()
      (let ((pair (car pairs)))
	(adjoin-set (make-leaf (car pair)
			       (cadr pair))
		    (make-leaf-set (cdr pairs))))))
;; ------------------------------
;; ex2.67
