;; 1<=j<i<=n 取i,j, i+j是素数
(load-r "c02/p76-covention-interface.scm")
(load-r "lib/math.scm")
(define n 6)
(accumulate append
	    ()
	    (map (lambda(i)
		   (map (lambda(j) (list i j))
			(enumerate-interval 1 (- i 1))))
		 (enumerate-interval 1 n)))

(define (flatmap proc seq)
  (accumulate append () (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (let ((a (car pair))
	(b (cadr pair)))
    (list a b (+ a b))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
	       (flatmap
		(lambda(i)
		  (map (lambda(j) (list i j))
		       (enumerate-interval 1 (- i 1))))
		(enumerate-interval 1 n)))))

(prime-sum-pairs 6)

(define (permutations s)
  (if (null? s)
      (list ()) ;sequence containing empty set 注意看注释
      (flatmap (lambda(x)
		 (map (lambda(p) (cons x p))
		      (permutations (remove-one x s))))
	       s)))
(define (remove-one item sequence)
  (filter
   (lambda(x) (not (= item x)))
   sequence))

(permutations (list 1 2 3))
