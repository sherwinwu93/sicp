(load-r "c03/p155-rand.scm")
;; 评估计算得出的PI
(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

;; 一次实验
(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

;; 进行trials次的experiment成功的概率
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
	   (/ trials-passed trials))
	  ((experiment)
	   (iter (- trials-remaining 1)
		 (+ trials-passed 1)))
	  (else
	   (iter (- trials-remaining 1)
		 trials-passed))))
  (iter trials 0))
