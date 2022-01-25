
(load-r "c02/p76-convention-interface.scm")
;; accumulate-n与accumulate类似
(define (accumulate-n op init seqs)
  (display seqs)
  (newline)
  (if (null? (car seqs))
      ()
      (cons (accumulate op init (map car seqs))
	    (accumulate-n op init (map cdr seqs)))))

(define s (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
;; (22 26 30)
(accumulate-n + 0 s)
