;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname funabst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Ryan Tonucci (21059852)
;;Assignment 8

;;2a
;;(or-pred pred? lst) produces true if any of the elements are true for the predicate
;;Examples
(check-expect (or-pred even? (list 3 5 6 7 9)) true)
(check-expect (or-pred odd? (list 2 4 10)) false)
;;or-pred: predicate (listof Any) -> Bool

(define (or-pred pred? lst)
  (cond [(empty? lst) false]
        [(pred? (first lst)) true]
        [else (or-pred pred? (rest lst))]))

;;tests
(check-expect (or-pred even? empty) false)
(check-expect (or-pred odd? (list 6 10 4)) false)
(check-expect (or-pred string? (list 5 "wow")) true)

;;2b
;;(map2argfn functions args) produces a list of function results when applied to the
;;list of numbers and the list of numbers
;;Examples
(check-expect (map2argfn (list + - * / list) (list 6 3))
              (list 9 3 18 2 (list 6 3)))
(check-expect (map2argfn (list + / * -) (list 6 3))
              (list 9 2 18 3))
;;map2argfn: (Num Num -> Num) (listof Num) -> (listof Num (listof Num))
;;Requires all elements of functions to consume two numbers.
;;Requires: args to be a 2 element list of numbers.

(define (map2argfn functions args)
  (cond [(empty? functions) empty]
        [else (cons ((first functions) (first args) (second args))
                    (map2argfn (rest functions) args))]))

;;2c
;;(arranged? predicate-function args) produces false if an element is not of type or
;;the list is not arranged in order according to the binary relational operator
;;Examples
(check-expect (arranged? (list number? >) (list 7 5 3)) true)
(check-expect (arranged? (list number? >) (list 2 7)) false)
;; arranged?: (list (Any -> Bool) (X X -> Bool)) (listof Any) -> Bool
;; requires: predicate-function produces true on elements of type X.

(define (arranged? predicate-function args)
  (cond [(empty? args) true]
        [(empty? (rest args)) (cond [((first predicate-function) (first args)) true]
                                    [else false])]
        [(not (and ((first predicate-function) (first args))
                   ((first predicate-function) (second args))
                   ((second predicate-function) (first args) (second args)))) false]
        [else (arranged? predicate-function (rest args))]))
        
;;Tests
(check-expect (arranged? (list string? string>?) (list "WOW" 'Rick "awesome")) false)
(check-expect (arranged? (list string? string<?) (list "awesome" "great" "zebra")) true)
(check-expect (arranged? (list integer? <) (list)) true)
(check-expect (arranged? (list integer? >) (list 1)) true)
(check-expect (arranged? (list integer? >) (list 'red)) false)
(check-expect (arranged? (list string? string>?) (list "wow" 'red)) false)
(check-expect (arranged? (list string? string>?) (list "wow" "cs135" "amazing")) true)


