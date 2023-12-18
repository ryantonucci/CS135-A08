;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname matrix) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Ryan Tonucci (21059852)
;;Assignment 8

;;5a
;; A Matrix is one of:
;; * empty
;; * (cons (listof Num) Matrix)
;; requires: each (listof Num) is non-empty and has the same length

;;(matrix-apply functions martix) produces a list of matrices that are the
;;result of applying each function.
;;Examples
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
(check-expect (matrix-apply (list abs sqr) M)
              (list (list (list 1 2 3)
                          (list 4 5 6)
                          (list 7 8.5 9))
                    (list (list 1 4 9)
                          (list 16 25 36)
                          (list 49 72.25 81))))
;;matrix-apply: (listof Num -> Num) Matrix -> (listof Matrix)

(define (matrix-apply ops Matrix)
  (local [(define (apply-helper op lst)
            (cond
              [(empty? lst) empty]
              [else (cons (op (first lst)) (apply-helper op (rest lst)))]))
          
          (define (apply-op op Matrix)
            (cond [(empty? Matrix) empty]
                  [else (cons (apply-helper op (first Matrix)) (apply-op op (rest Matrix)))]))
          
          (define (matrix-apply/acc ops Matrix acc)
            (cond [(empty? ops) acc]
                  [else (matrix-apply/acc (rest ops) Matrix
                                          (append acc (list (apply-op (first ops) Matrix))))]))]

    (matrix-apply/acc ops Matrix (list))))


;;5b
;;(scale-smallest Matrix offset) takes the smallest number in the matrix and multiplies it
;;by a factor then adds the offset.
;;Examples
(check-expect ((scale-smallest M 5) 4) 1)
(check-expect ((scale-smallest M 10) 2) 8) 
;;scale-smallest: (Matrix Num -> (function factor -> Num))

(define (scale-smallest Matrix offset)
  (local [(define (smallest-in-matrix Matrix min-so-far)
            (cond [(empty? Matrix) min-so-far]
                  [(< (min-in-row (first Matrix) (first (first Matrix))) min-so-far)
                   (smallest-in-matrix (rest Matrix) (min-in-row (first Matrix) (first (first Matrix))))]
                  [else (smallest-in-matrix (rest Matrix) min-so-far)]))     
          (define (min-in-row row lo)
            (cond [(empty? (rest row)) lo]
                  [(< (min (first row)) lo)
                   (min-in-row (rest row) (first row))]
                  [else (min-in-row (rest row) lo)]))]
    (lambda (factor)
      (+ (* (smallest-in-matrix Matrix (first (first Matrix))) factor) offset))))


;;Tests
(check-expect ((scale-smallest '((7 4.5 3.2) (-3 3 13)) 2.4) 7) -18.6)
(check-expect ((scale-smallest '((7 4.5 3.2) (-3 3 13)) 2.4) -2.7) 10.5)


