(define $sicp-dir "/root/git-code/sicp/src/")
(define (absolute relative)
  (string-append $sicp-dir
                 relative))
(define (load-r relative)
  (load (absolute relative)))
(load-r "c01/square.scm")
