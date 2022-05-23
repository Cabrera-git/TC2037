# Activity 3.4
##### Emiliano Cabrera - A01025453
##### Do Hyun Nam - A01025276
##### 22/05/2022

---

## The program
We've made a parser for .cpp files that utilizes Regex matching in order to differentiate between values, variables, punctiation, operators, keywords, and more.

```elixir
    defmodule Parser do
        def word_lexer(line, comment \\ false) do
            cond do
                [] == line ->
                    ""
                Type.is_break?(hd(line))->
                    hd(line) <> Parser.word_lexer(tl(line), false)
                Type.is_comment?(hd(line)) || comment ->
                    "<span class=\"comment\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line), true)
                Type.is_punctuation?(hd(line)) ->
                    "<span class=\"punctuation\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_opening_parenthesis?(hd(line)) ->
                    "<span class=\"parenthesis\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_closing_parenthesis?(hd(line)) ->
                    "<span class=\"parenthesis\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_opening_bracket?(hd(line)) ->
                    "<span class=\"bracket\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_closing_bracket?(hd(line)) ->
                    "<span class=\"bracket\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_semicolon?(hd(line)) ->
                    "<span class=\"semicolon\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_include?(hd(line)) ->
                    "<span class=\"include\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_reserved?(hd(line)) ->
                    "<span class=\"reserved\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_id?(hd(line)) ->
                    "<span class=\"id\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_int?(hd(line)) ->
                    "<span class=\"int\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_real?(hd(line)) ->
                    "<span class=\"real\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_op?(hd(line)) ->
                    "<span class=\"op\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_string?(hd(line)) ->
                    "<span class=\"string\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
                Type.is_space?(hd(line)) ->
                    " " <> Parser.word_lexer(tl(line))
                true ->
                    hd(line) <> Parser.word_lexer(tl(line))
            end
        end
    end
```
(<em>The entire conditional chunk of the code</em>

The above function defines the type of value that is presented. It uses a lot of boolean functions alongside Regex definitions to determine what the value is. An example of the boolean function is presented below.

```elixir
    def is_include?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/#include[ ]*&lt[a-zA-Z_0-9]*&gt|#include|&lt[a-zA-Z_0-9]*&gt/,atom) ->
                true
            true ->
                false
        end                
    end
```
<em>Regex check to see if the presented value is a library inclusion line</em>

Once a Regex match is evaluated as true, a string will be returned that resembles an HTML tag with an appropriate id. That will then be concatenated with more of the generated strings to make a full html document string.

## Complexity

The parser itself has a linear time complexity of O(n), considering it parses de cpp file line by line identifying with conditionals and regex matching the different identifiers within the language. After a condition and matching is made, then the HTML elements with their respective classes to highlight the syntaxis is replaced and saved within an HTML file. 

As for the reader and HTML functions they present a time complexity of 8\*O(n) and 6\*O(n) respectively. This is due to the fact that the program first replaces all parenthesis, brackets, and, braces before the regex matching, to avoid incorrect string matches. At last, the HTML function re-replaces the placeholding values of these identifiers to be correctly shown on the resulting file. 

## Conclusion

The program works and reaches the given objectives successfuly, considering the lenght of the files to be parsed, the time complexity doesn't imply a much bigger difference on the results. 
Although certainly, the program has room to improve in efficiency, as the Reader and HTML functions could be avoided when using more strict and specific regex matching. With this in mind, it would be a possibility to make the whole program's time complexity to O(n), which implies that it solely depends on the length of the file to be parsed. 

