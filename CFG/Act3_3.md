# Actividad 3.3 - Context Free Grammar
Emiliano Cabrera - A01025453 <br>
Do Hyun Nam - A01025276 <br><br>
29 de abril de 2022<br><br>
Prof. Gilberto Echeverría

---
##### *Escribe la notación BNF y EBNF para la gramática necesaria para definir modulos y funciones en Elixir.*
<br>

## **BNF**
### *Functions*
<function\> ::== def <variable\>(<variable-expression\>), do: <single-function-expression\> end | def <variable\>(<variable-expresson\>) do <function-expression\> end | def <variable\>, do: <single-function-expression\> end | def <variable\> do <function-expression\> end
<br>
<br>
<variable\> ::== <letter\><variable\> | _<variable\> | <letter\> | <letter\><number\>
<br>
<br>
<letter\> ::== a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z 
<br>
<br>
<number\> ::== <digit\> | <digit\><number\>
<br>
<br>
<digit\> ::== 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0
<br>
<br>
<variable-expression\> ::== <variable\> | <variable\>,<variable-expression\>
<br>
<br>
<single-function-expression\> ::== <number\> | <variable\> | <number\><operation\> | <real\><operation\> | true | false
<br>
<br>
<operation\> ::== <operator\><number\> | <operator\><real\>
<br>
<br>
<real\> ::== <number\>.<number\>
<br>
<br>
<operator\> ::== + | - | / | *
<br>
<br>
<function-expression\> ::== <single-function-expression\><function-expression\>

### *Modules*

<br>

## **EBNF**
### *Functions*
<function\> ::==

### *Modules*
