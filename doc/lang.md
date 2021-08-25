# Languages appears in the CLIX compiler

​	Since we are building the compiler in an incremental way, we need to specify the subsets of Lisp of each stage

## 1. R0-language



## 2. R1-language

### Language Feature

1. Arithmetic : only negative (-) and add (+) operators
2. IO : only read function (as input function)
3. Assignment : using let to bind a variable with a value

### EBNF for R1-lang

```pascal
exp ::= int | (read) | (- exp) | (+ exp exp) | var | (let ([var exp]) exp)
R1  ::= (program exp)
```

