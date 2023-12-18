;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname examples-a08) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Ryan Tonucci (21059852)
;;Assignment 8 Examples

;;1b
(check-expect (partition number? (list '2 "Jim" 4 6 7)) (list (list 4 6 7) (list '2 "Jim")))
(check-expect (partition string? (list 2 3 "Bob" 6  "Rick" 7)) (list (list "Bob" "Rick") (list 2 3 7)))

;;2a
(check-expect (or-pred even? (list 3 5 6 7 9)) true)
(check-expect (or-pred odd? (list 2 4 'WOW)) false)

;;2b
(check-expect (map2argfn (list + - * / list) (list 6 3))
              (list 9 3 18 2 (list 6 3)))
(check-expect (map2argfn (list + / * -) (list 6 3))
              (list 9 2 18 3))

;;2c
(check-expect (arranged? (list number? >) (list 7 5 3)) true)
(check-expect (arranged? (list number? >) (list 2 7)) false)
(check-expect (arranged? (list string? string>?) (list "WOW" 'Rick "awesome")) false)
(check-expect (arranged? (list string? string<?) (list "awesome" "great" "zebra")) true)

;;3
(define t (make-node 5
(make-node 33 empty empty)
                          (make-node 19
                                     (make-node 13 empty empty)
                                     (make-node 99 empty empty))))

(check-expect ((tree-pred odd?) t) false)
(check-expect ((tree-pred even?) t) true)

;;4b
(check-expect (nested-filter odd? (list (list 3 6 7 (list 4 5)) (list 4 10)))
              (list 3 7 5))
(check-expect (nested-filter odd? (list (list 3 6 7 (list 4 5)) (list 4 (list 3 9) 9 (list 4 7))))
              (list 3 7 5 3 9 9 7))

;;4c
(check-expect (ruthless (list (list 'ruth 'rick) (list 'bob 'rick) 'ruth (list 'jim (list 'ruth))))
              (list (list 'rick) (list 'bob 'rick) (list 'jim (list))))
(check-expect (ruthless (list (list (list 'ruth 'ruth 'bob) (list (list 'ruth 'rick))) (list 'rick)))
              (list (list (list 'bob) (list (list 'rick))) (list 'rick)))

;;4d
(check-expect (keep-between 4 7 (list (list 1 3 5 (list 3 4 7)) (list 4 10)))
              (list (list 5 (list 4 7) (list 4))))
(check-expect (keep-between 4 5 (list (list 1 3 5 (list 3 4 7)) (list 4 10)))
              (list (list 5 (list 4) (list 4))))

;;4e
(check-expect (nested-cleanup (list empty (list 4 empty empty) (list (list empty))))
              (list (list 4) (list (list))))
(check-expect (nested-cleanup (list (list empty empty (list 9 3)) (list empty) empty))
              (list (list (list 9 3)) (list)))

;;5a
(define M (list (list -1 2 3)
                (list 4 5 6)
                (list 7 8.5 9)))

(check-expect (matrix-apply (list sqr abs) M)
              (list (list (list 1 4 9)
                          (list 16 25 36)
                          (list 49 72.25 81))
                    (list (list 1 2 3)
                          (list 4 5 6)
                          (list 7 8.5 9))))
(check-expect (matrix-apply (list abs sqr))
              (list (list (list 1 2 3)
                          (list 4 5 6)
                          (list 7 8.5 9))
                    (list (list 1 4 9)
                          (list 16 25 36)
                          (list 49 72.25 81))))

;;5b
(check-expect ((scale-smallest M 5) 4) 1)
(check-expect ((scale-smallest M 10) 2) 12)             





