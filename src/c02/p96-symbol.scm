'(a b c d)
'(23 45 17)
'((Norah 12) (Molly 9) (Anna 7) (Lauren 6) (Charlotte 4))
'(* (+ 23 45) (+ x 9))
(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1)))))

(define a 1)
(define b 2)

(list a b)
;; (a b)
(list 'a 'b)
(list 'a b)
