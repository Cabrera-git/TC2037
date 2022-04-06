#lang racket

;Emiliano Cabrera, A01025453
;Do Hyun Nam, A01025276

(define (isComment string)
  (if(regexp-match #rx"/(?=/)" string)
     #t
     #f
  )
)

(define (isDivision string)
  (if(regexp-match #rx"/$" string)
     #t
     #f
  )
)

(define (isOpeningParenthesis string)
  (if(regexp-match #rx"[(]" string)
     #t
     #f
  )
)

(define (isClosingParenthesis string)
  (if(regexp-match #rx"[)]" string)
     #t
     #f
  )
)

(define (isAssignation string)
  (if(regexp-match-positions #rx"=$" string)
     #t
     #f
  )
)

(define (isSum string)
  (if(regexp-match-positions #rx"[+]$" string)
     #t
     #f
  )
)

(define (isSubstract string)
  (if(regexp-match #rx"-(?!.)" string)
     #t
     #f
  )
)

(define (isMulti string)
  (if(regexp-match-positions #rx"[*]" string)
     #t
     #f
  )
)

(define (isPower string)
  (if(regexp-match-positions #rx"\\^+" string)
     #t
     #f
  )
)

(define (isVariable string)
  (if(regexp-match-positions #rx"(?<![_0-9])[a-zA-Z]" string) 
     #t
     #f
  )
)

(define (isReal string)
  ;(if(regexp-match #rx"[-]?[0-9].[0-9]" string)
  (if(regexp-match #px"^([+-]?(\\d*\\.)?(?!.*?\\.\\.)\\d+[eE]?[-+]?\\d*?)|^[+-]?(?!.*?\\.\\.)[0-9.]+$" string)
     (if (regexp-match #px"^[^.]*$" string)
         #f
         #t
     )
     #f
  )
)

(define (isWhole string)
  ;(if(regexp-match #rx"[-]?[0-9]+[0-9]*" string)
  (if(regexp-match #px"^([-+]?\\d+$)" string)
     #t
     #f
  )
)

(define (printLine lst)
  (unless (empty? lst)
    (display (first lst))
    (display " ")
    (printLine (rest lst))
   )
)

#|
(define (iterate lst)
  (unless (empty? lst) ;Not empty
    (cond 
      [(isComment (first lst)) (printLine lst) (display "\tComentario\n")] ;isComment print whole line
      [(isDivision (first lst)) (display (first lst)) (display "\tDivision\n")]
      [(isOpeningParenthesis (first lst)) (display (first lst)) (display "\tParentesis que abre\n")]
      [(isClosingParenthesis (first lst)) (display (first lst)) (display "\tParentesis que cierra\n")]
      [(isAssignation (first lst)) (display (first lst)) (display "\tAsignacion\n")]
      [(isSum (first lst)) (display (first lst)) (display "\tSuma\n")]
      [(isSubstract (first lst)) (display (first lst)) (display "\tResta\n")]
      [(isMulti (first lst)) (display (first lst)) (display "\tMultiplicacion\n")]
      [(isPower (first lst)) (display (first lst)) (display "\tPotencia\n")]
      [(isReal (first lst)) (display (first lst)) (display "\tReal\n")]
      [(isWhole (first lst)) (display (first lst)) (display "\tEntero\n")]
      [(isVariable (first lst)) (display (first lst)) (display "\tVariable\n")]
      [else (display (first lst)) (display "\tError de formato\n")]
      
      
    )
    (if (not (isComment (first lst)))
        (iterate (rest lst))
        #f
    )
  )
) 
|#

(define (iterate lst)
  (define id null)
  (define v-i-pair null)

  (unless (empty? lst) ;Not empty
    (cond 
      [(isComment (first lst)) (set id "\tComentario\n")] ;isComment prints the whole line
      [(isDivision (first lst)) (set! id "\tDivision\n")]
      [(isOpeningParenthesis (first lst)) (set! id "\tParentesis que abre\n")]
      [(isClosingParenthesis (first lst)) (set! id "\tParentesis que cierra\n")]
      [(isAssignation (first lst)) (set! id "\tAsignacion\n")]
      [(isSum (first lst)) (set! id "\tSuma\n")]
      [(isSubstract (first lst)) (set! id "\tResta\n")]
      [(isMulti (first lst)) (set! id "\tMultiplicacion\n")]
      [(isPower (first lst)) (set! id "\tPotencia\n")]
      [(isReal (first lst)) (set! id "\tReal\n")]
      [(isWhole (first lst)) (set! id "\tEntero\n")]
      [(isVariable (first lst)) (set! id "\tVariable\n")]
      [else (set! id "\tError de formato\n")]
    )

    (set! v-i-pair (cons (first lst) id))

    (if (not (isComment (first lst)))
        (list v-i-pair (iterate (rest lst)))
        #f
    )
  )
)

(define (next-line-it file)
  (let ((line (read-line file 'any)))
    (unless (eof-object? line)
      (iterate (regexp-split #px" " line))
      (next-line-it file))))

(call-with-input-file "02.txt" next-line-it)