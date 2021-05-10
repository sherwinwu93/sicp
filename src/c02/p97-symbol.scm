(define a 1)
(define b 2)

;; (1 2)
(list a b)

;; (a b)
(list 'a 'b)

;; 也可用于复合对象
;; a
(car '(a b c))

;; (b c)
(cdr '(a b c))

;; memq过程:符合是否在表内
(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))
;; #f
(memq 'apple '(pear banana prune))
;; (apple pear)
(memq 'apple '(x (apple sauce) y apple pear))
