(load-r "c02/p186-make-table.scm")
(load-r "c02/p119-attach-tag.scm")
(load-r "c02/p125-apply-generic.scm")
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(load-r "c02/p129-install-scheme-number-package.scm")
(add (make-scheme-number 1) (make-scheme-number 2))

(load-r "c02/p129-install-rational-package.scm")
(add (make-rational 2 3) (make-rational 1 2))

(load-r "c02/p129-install-complex-package.scm")
(add (make-from-real-imag 1 2) (make-from-real-imag 3 4))
(mul (make-from-mag-ang 1 2) (make-from-mag-ang 3 4))