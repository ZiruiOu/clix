#lang racket/base

(require "utils.rkt")
(define R1-unique1 `(let ([x 10])
                     x))
(define R1-test1 `(program ,R1-unique1))
(displayln (uniquify R1-test1))

(define R1-unique2 `(let ([x 10])
                      (+ x
                         (let ([x 20])
                           (+ x
                              (let ([x 30])
                                (+ x
                                   (let ([x 40])
                                     (+ x
                                        (let ([x -100])
                                          x))))))))))

(define R1-test2 `(program ,R1-unique2))
(displayln (uniquify R1-test2))

(define R1-lists1 '(let ([x 10])
                     (let ([y 20])
                       (let ([z 30])
                         (let ([w 40])
                           (+ x y z w))))))
(define R1-test3 `(program ,R1-lists1))
(displayln (uniquify R1-test3))