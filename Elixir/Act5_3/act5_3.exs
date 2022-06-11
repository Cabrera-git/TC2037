# Actividad 5.3
# 
# Emiliano Cabrera - A01025453
# Do Hyun Nam - A01025276
# 2022-05-20

# Notes:
# Input files must be named "in_X.cpp", X being a positive integer with no leading 0's
# Output files wil be named in a similar fashion, "out_X.html"
# To run, simply call the function Parallel.parallel_write(X), X being the number of input files you'd like to parse 

defmodule Parser do
    def word_lexer(line, comment \\ false) do
        cond do
            [] == line ->
                ""
            is_break?(hd(line))->
                hd(line) <> Parser.word_lexer(tl(line), false)
            is_comment?(hd(line)) || comment ->
                "<span class=\"comment\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line), true)
            is_punctuation?(hd(line)) ->
                "<span class=\"punctuation\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_opening_parenthesis?(hd(line)) ->
                "<span class=\"parenthesis\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_closing_parenthesis?(hd(line)) ->
                "<span class=\"parenthesis\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_opening_bracket?(hd(line)) ->
                "<span class=\"bracket\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_closing_bracket?(hd(line)) ->
                "<span class=\"bracket\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_semicolon?(hd(line)) ->
                "<span class=\"semicolon\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_include?(hd(line)) ->
                "<span class=\"include\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_reserved?(hd(line)) ->
                "<span class=\"reserved\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_id?(hd(line)) ->
                "<span class=\"id\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_int?(hd(line)) ->
                "<span class=\"int\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_real?(hd(line)) ->
                "<span class=\"real\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_op?(hd(line)) ->
                "<span class=\"op\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_string?(hd(line)) ->
                "<span class=\"string\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            is_space?(hd(line)) ->
                " " <> Parser.word_lexer(tl(line))
            true ->
                hd(line) <> Parser.word_lexer(tl(line))
        end
    end
    
    def is_id?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/[a-zA-Z_]+[a-zA-Z_0-9]*;?/,atom) ->
                true
            true ->
                false
        end
    end
    
    def is_int?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/[0-9]+;?/,atom) ->
                true
            true ->
                false
        end        
    end
    
    def is_real?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/[+-]?[0-9]+[.][0-9]+([eE][+-]?[0-9]+)?;?/,atom) ->
                true
            true ->
                false
        end          
    end
    
    def is_op?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/[+][+]|[+]|[-][-]|[-]|[*]|[%]|[\/]|[\\^]|[!][=]|&lt&lt|&gt&gt|&gt=|&lt=|[=][=]|&lt|&gt|=/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_comment?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/[\/][\/]/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_string?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/\?*["][ a-zA-Z_0-9]*\?*["];?/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_reserved?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/if|else|while|for|do|const|int|float|string|char|void|return|continue|using|namespace|break|bool|static|new|null|false|switch|this|throw|case|true|catch|try|class|public|virtual|double|cout|cin|long;?/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_punctuation?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/\\[|\\]|\\{|\\}|\\(|\\)|\\[\\]|\\{\\}|\\(\\);*/,atom) ->
                true
            true ->
                false
        end                
    end
    
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
    
    def is_opening_parenthesis?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/&op/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_closing_parenthesis?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/&cp/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_opening_bracket?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/&ob/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_closing_bracket?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/&cb/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_space?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/&sp/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_semicolon?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/&sc/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_break?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/<br>/,atom) ->
                true
            true ->
                false
        end                
    end
end

defmodule HTML do
    def html_head(file_in) do
        "<!DOChtml>
        <html lang=\"es\">
        <head><meta charset=\"UTF-8\">
        <title>Analizador Lexico</title>
        <link href=\"styles.css\" rel=\"stylesheet\"></head>
        <body><pre>" <> Parser.word_lexer(String.split(file(file_in),"º"))
    end

    def file(file_in) do
        File.read!(file_in)
        |> String.replace("<","&lt")    
        |> String.replace(">","&gt")
        |> String.replace("\n","º<br>º")
        |> String.replace(" ","º&spº")
        |> String.replace("(","º&opº")
        |> String.replace(")","º&cpº")
        |> String.replace("[","º&obº")
        |> String.replace("]","º&cbº")
        |> String.replace(";","º&scº")
    end

    def html(file_in) do
        (html_head(file_in) <> "</pre></body></html>")
        |> String.replace("&op","(")
        |> String.replace("&cp",")")
        |> String.replace("&ob","[")
        |> String.replace("&cb","]")
        |> String.replace("&sc",";")
        |> String.replace("&sp"," ")
    end

    def html_write(filenames), do: File.write(tl(filenames), html(hd(filenames))) # call this function for linear execution
end

defmodule Parallel do
    def parallel_write(amount) do # call this function for parallel execution
        file_gen(amount)
        |> Enum.map(&Task.async(fn -> HTML.html_write(&1) end))
        |> Enum.map(&Task.await(&1))
    end

    def timer(function) do
        function
        |> :timer.tc()
        |> elem(0)
        |> Kernel./(1_000_000)
    end

    def file_gen(amount, curr \\ 1, lst \\ []) do
        lst1 = ["./Elixir/Act5_3/in_"<>to_string(curr)<>".cpp" | "./Elixir/Act5_3/out_"<>to_string(curr)<>".html"]
        
        if curr >= amount do
            [lst1 | lst]
        else
            file_gen(amount,curr+1,[lst1 | lst])
        end
    end
end

# run function
IO.puts("Parsing files...")
Parallel.parallel_write(20)
IO.puts("Files parsed")

# function runtime
IO.puts("\nRuntime:")
IO.puts(Parallel.timer(fn -> Parallel.parallel_write(20) end))