# Actividad 3.4
# 
# Emiliano Cabrera - A01025453
# Do Hyun Nam - A01025276
# 2022-05-20

defmodule Reader do
    def file() do
        File.read!("./Elixir/Act3_4/test.cpp")
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
    
    def is_opening_parenthesis?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/^[(]+$/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_closing_parenthesis?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/^[)]+$/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_opening_bracket?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/^[{]+$/,atom) ->
                true
            true ->
                false
        end                
    end
    
    def is_closing_bracket?(atom) do
        cond do
            nil == atom ->
                false
            Regex.match?(~r/^[}]+$/,atom) ->
                true
            true ->
                false
        end                
    end
end

defmodule Parser do
    def word_lexer(line) do
        cond do
            [] == line ->
                ""
            "" == hd(line) ->
                ""
            Type.is_include?(hd(line)) ->
                "<span class=include>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_reserved?(hd(line)) ->
                "<span class=reserved>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_id?(hd(line)) ->
                "<span class=id>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_int?(hd(line)) ->
                "<span class=int>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_real?(hd(line)) ->
                "<span class=real>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_op?(hd(line)) ->
                "<span class=op>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_string?(hd(line)) ->
                "<span class=string>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_comment?(hd(line)) ->
                "<span class=comment>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_punctuation?(hd(line)) ->
                "<span class=punctuation>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_opening_parenthesis?(hd(line)) ->
                "<span class=parenthesis>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_closing_parenthesis?(hd(line)) ->
                "<span class=parenthesis>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_opening_bracket?(hd(line)) ->
                "<span class=bracket>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_closing_bracket?(hd(line)) ->
                "<span class=bracket>" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            true ->
                hd(line) <> Parser.word_lexer(tl(line))
        end
    end
end

defmodule HTML do
    def html_head() do
        "<!DOCTYPE html><html lang=\"es\"><head><meta charset=\"UTF-8\"><title>Analizador Lexico</title><link href=\"styles.css\" rel=\"stylesheet\"></head><body>" <> Parser.word_lexer(String.split(Reader.file_br()))
    end

    def html() do
        HTML.html_head() <> "</body></html>"
    end

    def test() do
        File.write("./Elixir/Act3_4/out.html", HTML.html())
    end
end

HTML.test()
