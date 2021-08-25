#lang racket/base

(require racket/match)
(require "utils.rkt")

(provide interpretor)

(define (interpretor sexp)
  (define (inner-helper env)
    (λ (exp)
      (define recursion (inner-helper env))
      (match exp
        [(? fixnum?) exp]
        [(? symbol?) (lookup exp env)]
        [`(read)
          (define result (read))
          (cond [(fixnum? result) result]
                [else (error `R1-interpretor "should receive an integer" result)])]
        [`(- ,(app recursion child))
          (- child)]
        [`(+ ,(app recursion left) ,(app recursion right))
          (+ left right)]
        [`(let ([,var ,(app recursion val)]) ,child)
          (let ([new-env (cons (cons var val)
                               env)])
            ((inner-helper new-env) child))])))
  (match sexp
    [`(program ,exp) ((inner-helper '()) exp)]
    [_ (error `R1-interpretor "program expected start with 'program'" exp)]))