(load-r "c02/p106-tree.scm")
;; 过程list->tree:产生平衡二叉树
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

;; elts为一个序对:car部分是构造的树;cdr部分是未动过的元素
(define (partial-tree elts n)
  (if (= n 0)
      (cons () elts)
      ;; left-size:左树大小
      (let ((left-size (quotient (- n 1) 2)))
        ;; left-result:左结果(因为魔法)
        (let ((left-result (partial-tree elts left-size)))
          ;; left-tree:左树
          ;; non-left-elts:左余:左余分为this-entry和右结果
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            ;; this-entry: 当前值
            ;; right-result: 右结果(因为魔法)
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              ;; right-tree:右树
              ;; remaining-elts:最后剩余
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result))
                    ;; remaining-elts)
                    )
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))
;; a.简要并尽可能清除解释为什么partial-tree能够工作
;;   1.如果n=0,返回elts
;;   2.elts进行运算left-result(partial-tree elts left-size)=left-tree + non-left-elts;此时left-tree认为已经解决了,只需要解决non-left-elts
;;   3.non-left-elts分为this-entry + right-result. right-result分为right-tree和remaining-elts
;;   4. 再cons 树(this-entry left-tree right-tree),remaining-elts
;;   5. 由于左树数left-size = (- n 1)/2,right-size= n - (left-size + 1),所以left-size=right-size
(quotient (- 3 1) 2)
(list->tree (list 1 3 5 7 9 11))
;; time=O(n)
