#|
Emiliano Cabrera, A01025453
Do Hyun Nam, A01025276

Actividad 3.2 Deterministic Finite Automata
8 de abril del 2022
|#

#lang racket

(define (validate-string input-string dfa)
    "Determine if the input string is accepted by the dfa
    Ex: (validate-string 'abababa' (list accept-ab 'q0 '(q2)))
    Arguments:
    input-string - string
    dfa - list with these elements
        * transition function
        * start state
        * list of accept states
    Return: boolean"

    (let loop
        ([lst  (remove* (list #\space " ") (string->list input-string))] ;removes spaces from input string
        [state (second dfa)] ;calling second element in DFA list (start state)
        [token-list empty] ;list where token-types are stored when found
        [token-elements empty] ;list where elements are stored after the token type is defined
        [transition (first dfa)]) ;calling first elemnt of DFA list (transition function accept-arithmetic)
       
        (if (empty? lst)
            (if (member state (third dfa)) 
                (append token-list (list (list (list->string token-elements)state))) ;if current start state is a member of accept state list, add token-type to token-list
                 #f)
            (let-values 
                ([(state token-type) (transition state (first lst))]) ; define variable values with atributes state and transition
                (loop 
                    (rest lst) 
                    state 
                    (if token-type
                        (append token-list (list (list (list->string token-elements)token-type))) ; if a token-type was returned add to token-list, if not pass given token-list
                        token-list)
                    
                    (if token-type
                        (list (first lst))
                        (append token-elements (list (first lst)))) ; if a token-type is returned, also return list that contains token-elements

                    transition))))) ; calls transition function

(define (accept-arithmetic state symbol) ;transition function
    (let
        ([ops (list #\= #\+ #\* #\/ #\^)])
        (cond
            [(eq? state 'q0) (cond 
                [(char-numeric? symbol) (values 'int #f)]
                [(char-alphabetic? symbol) (values 'var #f)] 
                [(member symbol ops) (values 'invalid #f)]
                [(eq? symbol #\() (values 'par_0 #f)]
                [(eq? symbol #\)) (values 'invalid #f)]
                [(eq? symbol #\-) (values 'negative #f)]
                [(eq? symbol #\.) (values 'invalid #f)]
                [else (values 'invalid #f)])]
            [(eq? state 'int) (cond 
                [(char-numeric? symbol) (values 'int #f)]
                [(char-alphabetic? symbol) (values 'invalid #f)] 
                [(member symbol ops) (values 'op 'int)]
                [(eq? symbol #\() (values 'invalid #f)]
                [(eq? symbol #\)) (values 'par_1 'int)]
                [(eq? symbol #\-) (values 'negative 'int)]; integer is found
                [(eq? symbol #\.) (values 'decimal #f)]
                [else (values 'invalid #f)])]
            [(eq? state 'decimal) (cond 
                [(char-numeric? symbol) (values 'float #f)] ; decimal point is found
                [(char-alphabetic? symbol) (values 'invalid #f)] 
                [(member symbol ops) (values 'invalid #f)]
                [(eq? symbol #\() (values 'invalid #f)]
                [(eq? symbol #\)) (values 'invalid #f)]
                [(eq? symbol #\-) (values 'invalid #f)]
                [(eq? symbol #\.) (values 'invalid #f)]
                [else (values 'invalid #f)])]
            [(eq? state 'float) (cond 
                [(char-numeric? symbol) (values 'float #f)]
                [(char-alphabetic? symbol) (values 'invalid #f)]
                [(member symbol ops) (values 'op 'float)] ; float is found
                [(eq? symbol #\() (values 'invalid #f)]
                [(eq? symbol #\)) (values 'par_1 'float)] ; float inside parenthesis is found
                [(eq? symbol #\-) (values 'negative 'float)] ; negative float is found
                [(eq? symbol #\.) (values 'invalid #f)]
                [else (values 'invalid #f)])]
            [(eq? state 'var) (cond 
                [(char-numeric? symbol) (values 'var #f)]
                [(char-alphabetic? symbol) (values 'var #f)]
                [(member symbol ops) (values 'op 'var)] ; variable is found
                [(eq? symbol #\() (values 'invalid #f)]
                [(eq? symbol #\)) (values 'par_1 'var)] ; variable is found inside of parenthesis
                [(eq? symbol #\-) (values 'negative 'var)] ; negative variable is found
                [(eq? symbol #\.) (values 'invalid #f)]
                [else (values 'invalid #f)])]
            [(eq? state 'op) (cond 
                [(char-numeric? symbol) (values 'int 'op)] ; operator is found before int
                [(char-alphabetic? symbol) (values 'var 'op)] ; operator is found before variable
                [(member symbol ops) (values 'invalid #f)]
                [(eq? symbol #\() (values 'par_0 'op)] ; operator is found inside parenthesis
                [(eq? symbol #\)) (values 'invalid #f)]
                [(eq? symbol #\-) (values 'invalid #f)]
                [(eq? symbol #\.) (values 'invalid #f)]
                [else (values 'invalid #f)])]
            [(eq? state 'par_0) (cond 
                [(char-numeric? symbol) (values 'int 'par_0)] ; ( is found
                [(char-alphabetic? symbol) (values 'var 'par_0)] ; ( is found before variable
                [(member symbol ops) (values 'invalid #f)]
                [(eq? symbol #\() (values 'par_0 'par_0)] ; is found inside another (
                [(eq? symbol #\)) (values 'invalid #f)]
                [(eq? symbol #\-) (values 'negative 'par_0)] ; found before a negatve sign
                [(eq? symbol #\.) (values 'invalid #f)]
                [else (values 'invalid #f)])]
            [(eq? state 'par_1) (cond 
                [(char-numeric? symbol) (values 'invalid #f)]
                [(char-alphabetic? symbol) (values 'invalid #f)]
                [(member symbol ops) (values 'op 'par_1)] ; ) found after operator
                [(eq? symbol #\() (values 'invalid #f)]
                [(eq? symbol #\)) (values 'par_1 'par_1)] ; ) found before parenthesis is closed
                [(eq? symbol #\-) (values 'negative 'par_1)] ; - is outside )
                [(eq? symbol #\.) (values 'invalid #f)]
                [else (values 'invalid #f)])]
            [(eq? state 'negative) (cond 
                [(char-numeric? symbol) (values 'int 'op)] ; negative is found before int
                [(char-alphabetic? symbol) (values 'var 'op)] ;negative is found before variable
                [(member symbol ops) (values 'invalid #f)]
                [(eq? symbol #\() (values 'par_0 'op)] ; found before (
                [(eq? symbol #\)) (values 'invalid #f)]
                [(eq? symbol #\-) (values 'invalid #f)]
                [(eq? symbol #\.) (values 'invalid #f)]
                [else (values 'invalid #f)])]
            [(eq? state 'invalid) (values 'invalid #f)]))) ; defines invalid state


(define (arithmetic-lexer input-string) ; MAIN FUNCTION
    (validate-string input-string (list accept-arithmetic 'q0 (list 'int 'var 'par_1 'space 'float)))) ; calling DFA function (validate-string) & transition function (accecpt-arithmetic)