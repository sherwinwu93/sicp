(define $sicp-dir "/root/codes/sicp/src/")
(define (absolute relative)
  (string-append $sicp-dir
                 relative))
(define (load-r relative)
  (load (absolute relative)))
