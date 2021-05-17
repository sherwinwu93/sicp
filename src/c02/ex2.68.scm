(load-r "c02/p103-set-op.scm")
(load-r "c02/ex2.67.scm")
;; 过程encode:
;;   传参:消息:例如: (a b c d e f); 树: huffman树
;;   返回:编码后的二进制表: 例如: 0 1
(define (encode message tree)
  (if (null? message)
      ()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
;; 写出encode-symbol: 为出现在树中的符号报告错误
(define (encode-symbol symbol current-branch)
  (cond ((and (leaf? current-branch) (eq? (symbol-leaf current-branch) symbol))
         ())
        ((element-of-set? symbol (symbols current-branch))
         (if (element-of-set? symbol (symbols (left-branch current-branch)))
             (cons 0 (encode-symbol symbol (left-branch current-branch)))
             (cons 1 (encode-symbol symbol (right-branch current-branch)))))
        (else
         (error "not in tree " symbol))))
(encode '(a d a b b c a) sample-tree)
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
