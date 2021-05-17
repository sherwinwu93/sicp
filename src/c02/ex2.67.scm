(load-r "c02/p112-huffman.scm")
;; 定义编码树
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))
;; 定义样例消息
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
;; 用过程decode该消息的编码,给出编码结果
(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        ()
        (let ((next-branch (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(decode sample-message sample-tree)
;; (a d a b b c a)
