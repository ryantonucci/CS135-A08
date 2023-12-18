;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname tree-pred) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Ryan Tonucci (21059852)
;;Assignment 8

;;3
(define-struct node (key left right)) ;; A Node is a (make-node Nat BT BT)
;; A Binary Tree (BT) is one of:
;; * empty
;; * Node

(define t1 (make-node 5
                      (make-node 33 empty empty)
                      (make-node 19
                                 (make-node 13 empty empty)
                                 (make-node 99 empty empty))))
(define t2 (make-node 5
                      (make-node 10 empty empty)
                      (make-node 15
                                 (make-node 20 empty empty)
                                 (make-node 33 empty empty))))

;;(tree-pred pred? BT) produces true if the predicate is true for every
;;element in the tree
;;Examples
(check-expect ((tree-pred odd?) t1) true)
(check-expect ((tree-pred even?) t1) false)
;;tree-pred (Num -> Bool) BT -> Bool

(define (tree-pred pred?)
  (local [(define (apply BT)
            (cond [(empty? BT) true]
                  [(not (pred? (node-key BT))) false]
                  [(node? BT) (and (apply (node-left BT))
                                   (apply (node-right BT)))]))] apply))

;;Tests
(check-expect ((tree-pred even?) t2) false)
(check-expect ((tree-pred positive?) t2) true)



