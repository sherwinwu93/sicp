;; make-rat
(define (make-rat n d)
  (let ((g (gcd n d)))
    (let ((sn (/ n g))
	  (sd (/ d g)))
      (if (< sd 0)
	  (cons (- sn) (- sd))
	  (cons sn sd)))))

(make-rat -6 -9)
