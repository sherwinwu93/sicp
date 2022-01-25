(define $sicp-dir "~/localcodes/sicp/src")
(define (absolute-path relative-path)
  (string-append $sicp-dir
		 "/"
		 relative-path))
(define (load-r relative-path)
  (load (absolute-path relative-path)))
