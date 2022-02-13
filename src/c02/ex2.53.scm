(load-r "c02/p97-memq.scm")
;; (a b c)
(list 'a 'b 'c)
;; ((george))
(list (list 'george))
;; ((y1 y2))
(cdr '((x1 x2) (y1 y2)))
;; (y1 y2)
(cadr '((x1 x2) (y1 y2)))
;; false
(pair? (car '(a short list)))
;; false
(memq 'red '((red shoes) (blue socks)))
;; true
(memq 'red '(red shoes blue socks))
