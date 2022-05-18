# Actividad 3.4
# 
# Emiliano Cabrera - A01025453
# Do Hyun Nam - A01025276
# 2022-05-20

defmodule RegexParser do
    def case(line) do
        Regex.run(~r/\s*("\w+")\s*(:)\s*("(\w*[.:]*\s?)+"),?/, line)
        Regex.run(~r/\s*("\w+")\s*(:)\s*\d+(\.\d+E[\+-]?\d+)?,?/, line)
        Regex.run(~r/\s*("\w+")\s*(:)\s*(true|false|null),?/, line)
        Regex.run(~r/[\[\]{}]/, line)
        Regex.run(~r//, line)
    end

    def color(token, id) do
        case do
            id == 's' ->
                html_add = '<p id="string">'+token+'<\p>'
            id == 'n' ->
                html_add = '<p id="number">'+token+'<\p>'
            id == 'k' ->
                html_add = '<p id="keyword">'+token+'<\p>'
            id == 'g' ->
                html_add = '<p id="key">'+token+'<\p>'
            id == 'p' ->
                html_add = '<p id="separator">'+token+'<\p>'
        end

        html_add
    end
end