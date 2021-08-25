#lang racket/base

(require "interpretor.rkt")

(define R1-test1 '(program (+ 1 2)))
(displayln (interpretor R1-test1))

(define R1-assign1 '(let ([x (+ 10 20)])
                      (+ x 30)))
(define R1-test2 `(program ,R1-assign1))
(displayln (interpretor R1-test2))

(define R1-assign2 '(let ([x (+ 10 20)])
                      (+ (let ([x (- (+ 15 15))])
                           x)
                         x)))
(define R1-test3 `(program ,R1-assign2))
(displayln (interpretor R1-test3))

(define R1-read1 '(+ (read) (read)))
(define R1-test4 `(program ,R1-read1))
(displayln (interpretor R1-test4))

(define R1-read2 '(let ([x (+ (- 30)
                              (+ 4 3))])
                    (+ x (read))))
(define R1-test5 `(program ,R1-read2))
(displayln (interpretor R1-test5))