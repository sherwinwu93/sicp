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

(define leaf1 (make-leaf 'A 4))
(leaf? leaf1)
(leaf? '(A 4))
(symbol-leaf leaf1)
(weight-leaf leaf1)


;; 树的表示 由左右分支构造, 生成 left+right+(left的符号集合+right的符合集合)+(left的权重+right的权重)
(define (make-code-tree left right)
  (list left
	right
	(append (symbols left) (symbols right))
	(+ (weight left) (weight right))))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define tree1 (make-code-tree
	       (make-leaf 'A 4)
	       (make-code-tree
		(make-leaf 'B 2)
		(make-leaf 'C 2))))
(left-branch tree1)
(right-branch tree1)
(symbols tree1)
(weight tree1)

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
;; ------------------------------ 2.67
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
		  (make-code-tree
		   (make-leaf 'B 2)
		   (make-code-tree (make-leaf 'D 1)
				   (make-leaf 'C 1)))))
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(decode sample-message sample-tree)
;; ------------------------------ 2.68 写出encode-symbol过程
;; message通过tree转bits
(define (encode message tree)
  (if (null? message)
      ()
      (append (encode-symbol (car message) tree)
	      (encode (cdr message) tree))))
(load-r "c02/p103-collection.scm")
(define (encode-symbol symbol tree)
  (define (encode-symbol-1 symbol tree)
    (if (leaf? tree)
	()
	(let ((lb (left-branch tree))
	      (rb (right-branch tree)))
	  (if (element-of-set? symbol (symbols lb))
	      (cons 0 (encode-symbol-1 symbol lb))
	      (cons 1 (encode-symbol-1 symbol rb))))))
  (if (element-of-set? symbol (symbols tree))
      (encode-symbol-1 symbol tree)
      (error "UNKNOWN SYMBOL " symbol)))
(encode '(a d a b b c a) sample-tree)
;; ------------------------------ 2.69 符号-频度对偶表
;; 以符号-权重表为参数,生产huffman-tree
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))
;; 写出successive-merge,使用make-code-tree反复归并集合中最小权重的元素,直至只剩下最后一个元素为止(这个元素是Huffman树_
(load-r "lib/single-operand.scm")
(define (successive-merge leaf-sets)
  (if (single-operand? leaf-sets)
      (car leaf-sets)
      (make-code-tree (car leaf-sets)
		      (successive-merge (cdr leaf-sets)))))
(generate-huffman-tree '((A 4) (B 2) (C 1) (D 1)))
;; ------------------------------ 2.70
(define rock-tree (generate-huffman-tree '((a 2) (boom 1) (get 2) (job 2) (na 16) (sha 3) (yip 9) (wah 1))))
(encode '(get a job sha na na na na na na na na get a sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip yip sha boom) rock-tree)
;; 定长36*3 = 108
;; 变长189
;; ------------------------------ 2.71
;; n=5: 最频繁是1,最不频繁是4
;; n=10: 最频繁是1,最不频繁是9
;; ------------------------------ 2.72
;; (n-1)+(n-2)+...+2+1 = O(n^2)
;; 最频繁O(n^2),最不频繁O(1)
