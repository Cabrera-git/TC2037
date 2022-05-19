# Actividad 3.4
# 
# Emiliano Cabrera - A01025453
# Do Hyun Nam - A01025276
# 2022-05-20

defmodule Reader do
    def file() do
        {:ok, contents} = File.read("./Elixir/Act3_4/test.cpp")
        contents
    end

    def file_lt() do
        String.replace(Reader.file(),"<","&lt")
    end

    def file_gt() do
        String.replace(Reader.file_lt(),">","&gt")
    end

    def file_br() do
        String.replace(Reader.file_gt(),"\r\n"," <br> ")
    end
end

defmodule Type do
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
            Regex.match?(~r/[\/][\/][ a-zA-Z_0-9]*;?/,atom) ->
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
end

defmodule Parser do
    def word_lexer(line) do
        [h|t] = line
        cond do
            nil == line ->
                ""
            Type.is_include?(hd(line)) ->
                "<span class=include" ++ h ++ "</span>" ++ Parser.word_lexer(t)
            Type.is_reserved?(hd(line)) ->
                "<span class=include" ++ h ++ "</span>" ++ Parser.word_lexer(t)
            Type.is_id?(hd(line)) ->
                "<span class=include" ++ h ++ "</span>" ++ Parser.word_lexer(t)
            Type.is_int?(hd(line)) ->
                "<span class=include" ++ h ++ "</span>" ++ Parser.word_lexer(t)
            Type.is_real?(hd(line)) ->
                "<span class=include" ++ h ++ "</span>" ++ Parser.word_lexer(t)
            Type.is_op?(hd(line)) ->
                "<span class=include" ++ h ++ "</span>" ++ Parser.word_lexer(t)
            Type.is_string?(hd(line)) ->
                "<span class=include" ++ h ++ "</span>" ++ Parser.word_lexer(t)
            Type.is_comment?(hd(line)) ->
                "<span class=include" ++ h ++ "</span>" ++ Parser.word_lexer(t)
            Type.is_punctuation?(hd(line)) ->
                "<span class=include" ++ h ++ "</span>" ++ Parser.word_lexer(t)
            true ->
                h ++ Parser.word_lexer(t)
        end
    end
end

defmodule HTML do
    def html_head() do
        "<!DOCTYPE html><html lang=\"es\"><head><meta charset=\"UTF-8\"><title>Analizador Lexico</title><link href=\"styles.css\" rel=\"stylesheet\"></head><body>" ++ Parser.word_lexer(String.split(Reader.file_br))
    end

    def html() do
        HTML.html_head() ++ "</body></html>"
    end

    def test() do
        File.write("./Elixir/Act3_4/out.html", HTML.html())
    end
end

# HTML.test()
IO.inspect String.split(Reader.file_br)