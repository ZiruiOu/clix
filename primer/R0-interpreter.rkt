#lang racket/base

(require racket/match
         racket/string)

(define/match (my-fact x)
  [(0) 1]
  [(x) (* x (my-fact (- x 1)))])

(define (R0-lang? sexp)
  (define (expression? exp)
    (match exp
      [(? fixnum?) #true]
      [`(read) #true]
      [`(- ,child) (expression? child)]
      [`(+ ,left ,right) (and (expression? left)
                              (expression? right))]
      [`(* ,left ,right) (and (expression? left)
                              (expression? right))]
      [`(modulo ,left ,right) (and (expression? left)
                                   (expression? right))]
      [_ #false]))
  (match sexp
    [`(program ,exp) (expression? exp)]
    [_ #false]))

(define (R0-interpretor sexp)
  (define (exp-eval exp)
    (match exp
      [(? fixnum?) exp]
      [`(read) (read)]
      [`(- ,child) (- (exp-eval child))]
      [`(+ ,left ,right) (+ (exp-eval left)
                            (exp-eval right))]
      [`(* ,left ,right) (* (exp-eval left)
                            (exp-eval right))]
      [`(modulo ,left ,right) (modulo (exp-eval left)
                                      (exp-eval right))]
      [_ (error "R0-interpretor : undefined operations")]))
  (match sexp
    [`(program ,exp) (exp-eval exp)]
    [_ (error "R0-interpretor : Ro program should start with 'program'")]))
      