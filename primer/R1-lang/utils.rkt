#lang racket/base

(require racket/match)

(provide lookup
         uniquify)

(define lookup
  (λ (exp env)
    (cond [(null? env)
           (error `R1-env-lookup "undefined symbol" exp)]
          [(eq? (caar env) exp)
           (cdar env)]
          [else (lookup exp (cdr env))])))

(define (uniquify sexp)
  (define (rename items)
    (λ (exp)
      (match exp
        [(? fixnum?) exp]
        [(? symbol?)
         (lookup exp items)]
        [`(let ([,var ,val]) ,exp)
          (let ([temp-var (gensym var)])
            (let ([new-env (cons (cons var
                                       temp-var)
                               items)])
            `(let ([,temp-var ,((rename items) val)])
               ,((rename new-env) exp))))]
        [`(,op ,exps ...)
         `(,op ,@(map (rename items) exps))])))
  (match sexp
    [`(program ,exp)
     `(program ,((rename '()) exp))]
    [_ (error `uniquify "R1-lang expect 'program' at start" sexp)]))