(load-r "c03/p155-rand.scm")
(define (estimate-pi trials)
  (sqrt (/ 6 (random-gcd-test trials random-init))))

(define (random-gcd-test trials initial-x)
  (define (iter trials-remaining trials-passed x)
    (let ((x1 (rand-update x)))
      (let ((x2 (rand-update x1)))
	(cond ((= trials-remaining 0)
	       (/ trials-passed trials))
	      ((= (gcd x1 x2) 1)
	       (iter (- trials-remaining 1)
		     (+ trials-passed 1)
		     x2))
	      (else
	       (iter (- trials-remaining 1)
		     trials-passed
		     x2))))))
  (iter trials 0 initial-x))
;; 与所有状态都必须显试操作和传递额外参数相比,引入赋值和状态隐藏在局部变量的技术,更模块化地构造系统. !!! ???
