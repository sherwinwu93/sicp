(load-r "lib/rand-update.scm")
(define random-init 0)
(define rand
  (let ((x random-init))
    (lambda()
      (set! x (rand-update x))
      x)))
