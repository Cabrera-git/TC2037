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
        String.replace(Reader.file_gt(),"\n","<br>")
    end

    def file_sp() do
        String.replace(Reader.file_br()," ","º&spº")
    end

    def file_op() do
        String.replace(Reader.file_sp(),"(","º&opº")
    end

    def file_cp() do
        String.replace(Reader.file_op(),")","º&cpº")
    end

    def file_ob() do
        String.replace(Reader.file_cp(),"[","º&obº")
    end

    def file_cb() do
        String.replace(Reader.file_ob(),"]","º&cbº")
    end

    def file_sc() do
        String.replace(Reader.file_cb(),";","º&scº")
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
end

defmodule Parser do
    def word_lexer(line) do
        cond do
            [] == line ->
                ""
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
            Type.is_comment?(hd(line)) ->
                "<span class=\"comment\">" <> hd(line) <> "</span>" <> Parser.word_lexer(tl(line))
            Type.is_space?(hd(line)) ->
                " " <> Parser.word_lexer(tl(line))
            true ->
                hd(line) <> Parser.word_lexer(tl(line))
        end
    end
end

defmodule HTML do
    def html_head() do
        "<!DOCTYPE html>
        <html lang=\"es\">
        <head><meta charset=\"UTF-8\">
        <title>Analizador Lexico</title>
        <link href=\"styles.css\" rel=\"stylesheet\"></head>
        <body><pre>" <> Parser.word_lexer(String.split(Reader.file_sc(),"º"))
    end

    def html() do
        HTML.html_head() <> "</pre></body></html>"
    end

    def replacer_op() do
        String.replace(HTML.html(),"&op","(")
    end

    def replacer_cp() do
        String.replace(HTML.replacer_op(),"&cp",")")
    end

    def replacer_ob() do
        String.replace(HTML.replacer_cp(),"&ob","[")
    end

    def replacer_cb() do
        String.replace(HTML.replacer_ob(),"&cb","]")
    end

    def replacer_sc() do
        String.replace(HTML.replacer_cb(),"&sc",";")
    end

    def replacer_sp() do
        String.replace(HTML.replacer_sc(),"&sp"," ")
    end

    def test() do
        File.write("./Elixir/Act3_4/out.html", HTML.replacer_sp())
    end
end

HTML.test()