;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname nested) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Ryan Tonucci (21059852)
;;Assignment 8


;;4a
;; A (nested-listof X) is one of:
;; * empty
;; * (cons (nested-listof X) (nested-listof X))
;; * (cons X (nested-listof X))
;; Requires: X itself is not a list type

;;nested-listof-X-template: (nested-listof X) -> (nested-listof-X)

(define (nested-listof-X-template nested-list)
  (cond [(empty? nested-list) ...]
        [else (... (cond [(list? (first nested-list))
                          (nested-list-of-X-template (first nested-list))] 
                         [else (first nested-list)])
                         (nested-list-of-X-template (rest nested-list)))]))
                       
                                
;;4b
;;(nested-filter pred? nested-list) returns the nested-list without the
;;cases where the predicate is false.
;;Examples                        
(check-expect (nested-filter odd? (list (list 3 6 7 (list 4 5)) (list 4 10)))
              (list (list 3 7 (list 5)) empty))
(check-expect (nested-filter odd? (list (list 3 6 7 (list 4 5)) (list 4 (list 3 9) 9 (list 4 7))))
              (list (list 3 7 (list 5)) (list (list 3 9) 9 (list 7))))
;;nested-filter: (X -> Bool) (nested-listof-X) -> (listof X)
  
(define (nested-filter pred? nested-list)
  (cond [(empty? nested-list) empty]
        [(and (not (list? (first nested-list))) 
              (not (pred? (first nested-list))))
         (nested-filter pred? (rest nested-list))]
        [else (cons (cond [(list? (first nested-list))
                           (nested-filter pred? (first nested-list))] 
                          [else (first nested-list)])
                    (nested-filter pred? (rest nested-list)))]))

;;Test
(check-expect (nested-filter symbol?
                             (list 5 10 (list 1 3 5) (list 7 9 10) (list 8 (list 3 4)) 8 15))
              (list empty empty (list empty)))

;;4c
;;(ruthless nested-list) removes all instances of 'ruth from a
;;nested list of symbols
;;Examples
(check-expect (ruthless (list (list 'ruth 'rick) (list 'bob 'rick) 'ruth (list 'jim (list 'ruth))))
              (list (list 'rick) (list 'bob 'rick) (list 'jim (list))))
(check-expect (ruthless (list (list (list 'ruth 'ruth 'bob) (list (list 'ruth 'rick))) (list 'rick)))
              (list (list (list 'bob) (list (list 'rick))) (list 'rick)))
;;ruthless: (nested-listof-Sym) -> (nested-listof-Sym)

(define (ruthless nested-list)
  (nested-filter ruth? nested-list))

(define (ruth? Sym) ;reverse the logic so it works with nested-filter
  (cond [(symbol=? 'ruth Sym) false]
        [else true]))
 

;;4d
;;(keep-between a b nested-list) produces the nested-list with only
;;the numbers >=a and <=b 
;;Examples
(check-expect (keep-between 4 7 (list (list 1 3 5 (list 3 4 7)) (list 4 10)))
              (list (list 5 (list 4 7)) (list 4)))
(check-expect (keep-between 4 5 (list (list 1 3 5 (list 3 4 7)) (list 4 10)))
              (list (list 5 (list 4)) (list 4)))
;;keep-between: (nested-listof-Num) -> (nested-listof-Num)                          
;;Requires: a >= b

(define (keep-between a b nested-list)
  (nested-filter (interval? a b) nested-list))

(define (interval? a b)
  (local [(define (f Num)
            (and (>= Num a) (<= Num b)))] f))

;;4e

;;(nested-cleanup nested-list) removes empty lists from the nested list
;;Examples
(check-expect (nested-cleanup (list empty (list 4 empty empty) (list (list empty))))
              (list (list 4)))
(check-expect (nested-cleanup (list (list empty empty (list 9 3)) (list empty) empty))
              (list (list (list 9 3))))
;;nested-cleanup: (nested-listof-Any) -> (nested-listof-Any)


(define (nested-cleanup nested-list)
 (cond [(empty? nested-list) empty]
        [(empty? (first nested-list)) (nested-cleanup (rest nested-list))]
        [(list? (first nested-list))
         (append (cond [(empty? (nested-cleanup (first nested-list))) empty]
                       [else (list (nested-cleanup (first nested-list)))])
                 (nested-cleanup (rest nested-list)))]
        [else (cons (first nested-list)
                    (nested-cleanup (rest nested-list)))]))
         

 

(check-expect (nested-cleanup '(1 () 2 () () 3)) '(1 2 3))
(check-expect (nested-cleanup '(1 (()()) 2 ((3 () (()))) )) '(1 2 ((3))))
(check-expect (nested-cleanup '(()(()())(())())) false)



