;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname partition) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;(partition predicate lst) produces a liost of two lists the first where elements of
;;lst are true the second where elements of lst are false.
;;Examples
(check-expect (partition number? (list 'no "Jim" 4 6 7))
              (list (list 4 6 7) (list 'no "Jim")))
(check-expect (partition string? (list 2 3 "Bob" 6  "Rick" 7))
              (list (list "Bob" "Rick") (list 2 3 6 7)))
;;partition: predicate (listof Any) -> (listof (listof Any) (listof Any))

(define (partition pred? lst)
  (local [(define (partition/acc pred? lst acc1 acc2)
  (cond [(empty? lst) (list acc1 acc2)]
        [(pred? (first lst))
         (partition/acc pred? (rest lst)
                        (append acc1 (list (first lst)))
                              acc2)]
        [else (partition/acc pred? (rest lst) acc1
                             (append acc2 (list (first lst))))]))]
    (partition/acc pred? lst empty empty)))


                                                       