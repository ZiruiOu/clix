#lang racket/base

(require racket/match)

(define (pe-neg n)
  (cond [(fixnum? n) (- 0 n)]
        [else `(- ,n)]))

(define (pe-add left right)
  (cond [(and (fixnum? left) (fixnum? right)) (+ left right)]
        [else `(+ ,left ,right)]))

(define (pe-eval exp)
  (match exp
    [(? fixnum?) exp]
    [`(read) `(read)]
    [`(- ,(app pe-eval exp))
      (pe-neg exp)]
    [`(+ ,(app pe-eval left) ,(app pe-eval right))
      (pe-add left right)]))
