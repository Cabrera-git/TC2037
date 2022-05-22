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


<!-- 

Esto es ejemplo de Andrew y Juan, me pasaron el doc para copiar. Borralo when you are done

The program holds a time complexity of O(n) as the execution time depends on the length of the file stream. Our file uses a pipeline which always holds an O(n) time complexity by mapping the file stream and recursively operating it, filtering out nil values, and then generating the html document with the resulting string built with every recursive step.

```elixir
  def get_lines(in_filename, out_filename) do
    expr =
      in_filename
      |> File.stream!()
      |> Enum.map(&token_from_line/1)
      |> Enum.filter(&(&1 != nil))
    tmp = "<!DOCTYPE html>\n<html>\n\t<head>\n\t\t<title>JSON Code</title>\n\t\t<link rel='stylesheet' href='token_colors.css'>\n\t</head>\n\t<body>\n\t\t<h1>Date: #{DateTime.utc_now}</h1>\n\t\t<pre>\n\t\t\t#{expr}\n\t\t\t</pre>\n\t</body>\n</html>"
    expr = tmp
    File.write(out_filename, expr)
  end
```
##### (<em>Don't mind our brute force solution for generating the html page.</em>)

By implementing tail recursion, space complexity is reduced to O(1) complexity as stack frames are disposed of in each step.

```elixir
  def token_from_line(line) do
    token_from_line(line,"",false,true)
  end
```

As for the code itself, as seen in the regex example previously, every regex match/run operation has O(n) time complexity, as the match depends on the length of the line being evaluated. By pattern matching to obtain the regex match tail, time complexity is still O(n), as a simple head | tail pattern match of the regex expression has O(1) compelxity. The same holds for Regex.split operations, as the same pattern match of the regex evaluation of a line occurs. -->

## Conclusion

<!-- 

Esto es ejemplo de Andrew y Juan, me pasaron el doc para copiar. Borralo when you are done

We believe this approach can be very efficient in contrast to using, ie. String.replace method for generating the resulting html file, which would imply an O(n^2) complexity. By implementing tail recursion with purely linear and constant operations, our program execution time soley depends on the length of the file. This in turn let us extract tokens with ease by using pattern matching with the same expression, and execute operations in a sequential manner for every regex match case. -->