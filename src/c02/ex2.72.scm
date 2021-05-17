(load "./ex2.68.scm")
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
;; 2.68encode的步数增长速率?
;; 考虑特殊情况,和ex2.71一样的huffman树.给出编码最频繁的符号所需的步树和最不频繁的符号
;; 假如:message是n个
;;  最不频繁的步数:n
;;  最频繁的步数: n(log n)
