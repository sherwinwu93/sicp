(define (double x)
  (* 2 x))

(define (halve x)
  (/ x 2))

;; time=O(n)
(define (multi a b)
  (if (= b 0)
      0
      (+ a (multi a (- b 1)))))

(multi 2 1999)

;;time=O(logn)
(define (fast-multi a b)
  (cond ((= b 0) 0)
	((even? b) (double (fast-multi a (halve b))))
	(else (+ a (fast-multi a (-1+ b))))))

(fast-multi 2 899)
