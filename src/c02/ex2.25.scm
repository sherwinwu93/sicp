(1 3 (5 7) 9)
a=(5 7)
(cons 5 (cons 7 ()))
(1 3 a 9)
(cons 1 (cons 3 (cons a (cons 9 ()))))
(cons 1
      (cons 3
            (cons (cons 5 (cons 7 ()))
                  (cons 9
                        ()))))

((7))
(cons (cons 7 ()) ())

(1 (2 (3 (4 (5 (6 7))))))
(cons 1
      (cons (cons 2
                  (cons (cons 3
                              (cons (cons 4
                                          (cons (cons 5
                                                      (cons (cons 6
                                                                  (cons 7 ()))
                                                            ()))
                                                ()))
                                    ()))
                        ()))
            ()))
x1=(2 (3 (4 (5 (6 7)))))
(cons 2
      (cons (cons 3
                  (cons (cons 4
                              (cons (cons 5
                                          (cons (cons 6
                                                      (cons 7 ()))
                                                ()))
                                    ()))
                        ()))
            ()))
x2=(3 (4 (5 (6 7))))
(cons 3
      (cons (cons 4
                  (cons (cons 5
                              (cons (cons 6
                                          (cons 7 ()))
                                    ()))
                        ()))
            ()))
x3=(4 (5 (6 7)))
(cons 4
      (cons (cons 5
                  (cons (cons 6
                         (cons 7 ()))
                        ()))
            ()))
x4=(5 (6 7))
(cons 5
      (cons (cons 6
                  (cons 7 ()))
            ()))
x5=(6 7)
(cons 6
      (cons 7
            ()))
