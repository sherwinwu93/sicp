;; 消息传递风格实现make-from-mag-ang.
(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else
           (error "Unknown op -- MAKE-FROM-MAG-ANG" op))))
  dispatch)

(define (apply-generic op arg) (arg op))

(apply-generic 'real-part (make-from-mag-ang 5 0.92))
(apply-generic 'imag-part (make-from-mag-ang 5 0.92))
(apply-generic 'magnitude (make-from-mag-ang 5 0.92))
(apply-generic 'angle (make-from-mag-ang 5 0.92))
