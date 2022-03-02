#|
Tarea 1

Emiliano Cabrera
2022-02-25
|#

#lang racket

(provide fahrenheit-to-celsius sign roots bmi factorial duplicate pow fib enlist positives add-list invert-pairs list-of-symbols? swapper)

" 1.- fahrenheit-to-celsius - Converts Fahrenheit to Celsius "
(define (fahrenheit-to-celsius temp) 
	(/ (* (- temp 32.0) 5) 9)
)

" 2.- sign - Indicates whether a number is zero, negative or positive "
(define (sign n) 
	(cond 
		[(zero? n) 'zero]
		[(> n 0) 'positive]
		[else 'negative]
	)
)

" 3.- roots - Returns the square root of a function based on coeficients a, b, and c "
(define (roots a b c) 
	(/ (- (sqrt (- (expt b 2) (* 4.0 a c))) b) (* 2 a))
)

" 4.- bmi - Returns BMI description based on weight (kg) and height (m) "
(define (bmi-calc w h)
	(/ w (expt h 2))
)

(define (bmi weight height) 
	(cond
		[(< (bmi-calc weight height) 20) (print "underweight")]
		[(and (< (bmi-calc weight height) 25) (<= (bmi-calc weight height) 20)) (print "normal")]
		[(and (< (bmi-calc weight height) 30) (<= (bmi-calc weight height) 25)) (print "obese1")]
		[(and (< (bmi-calc weight height) 40) (<= (bmi-calc weight height) 30)) (print "obese2")]
		[else (print "obese3")]
	)
)

" 5.- factorial - Returns the corresponding factorial "
(define (factorial n) 
	(cond
		[(< n 0) "n must be positive"]
		[(zero? n) 1]
		[else (* n (factorial (- n 1)))]
	)
)

" 6.- duplicate - Duplicates the elements within a list "
(define (duplicate lst) 
	(append lst lst)
)

" 7.- pow - Returns a number a elevated to the power b "
(define (pow a b) 
	(expt a b)
)

" 8.-  fib - Returns nth number in the fibonacci sequence "
(define (fib n) 
	(cond
		[(= n 0) 0]
		[(= n 1) 1]
		[else (+ (fib (- n 1)) (fib (- n 2)))]
	)
)

" 9.- enlist - Inserts every higher-level element from a list into another list "
(define (enlist lst)
	(if (empty? lst) 
		lst 
		(append (list (list (car lst))) (enlist (cdr lst)))
	)
)

" 10.- positives - Returns only positive numbers from a list "
(define (positives lst)
	(if (empty? lst)
		lst
		(if (> (car lst) 0)
			(append (list (car lst)) (positives (cdr lst)))
			(positives (cdr lst))
		)
	)
)

" 11.- add-list - Sums all items within a list "
(define (add-list lst)
	(apply + lst)
)

" 12.- invert-pairs - Inverts order of the inner-list items "
(define (invert-pairs lst)
	(if (empty? lst)
		lst
		(map (lambda (item) (append (cdr item) (list (car item)))) lst)
	)
)

" 13.- list-of-symbols? - Returns whether all elements within a list are symbols "
(define (list-of-symbols? lst)
	(if (empty? lst)
		#t
		(if (symbol? (car lst))
			(list-of-symbols? (cdr lst)) #f)
	)
)

" 14.- swapper - Swaps instances of a for b, and viceversa, within a list "
(define (swapper a b lst)
	(if (empty?) lst)
		lst
		(cond
			[(equal? (car lst) a) (append b (swapper a b (cdr lst)))]
			[(equal? (car lst) b) (append a (swapper a b (cdr lst)))]
			[else (swapper a b (cdr lst))]
		)
	)
)
