# Actividad 3.4
# 
# Emiliano Cabrera - A01025453
# Do Hyun Nam - A01025276
# 2022-05-20

defmodule RegexParser do
    def case(line) do
        case do
            Regex.match?(~r/(\s*"\w+")(\s*:\s*)("(\w*[.:]*\s?)+")/, line) -> # ( object-key)( : )(string )

            Regex.match?(~r/(\s*"\w+")(\s*:\s*)(\d+(\.\d+E[\+-]?\d+)?)/, line) -> # ( object-key)( : )(number )

            Regex.match?(~r/(\s*"\w+")(\s*:\s*)((true|false|null)\s*)/, line) -> # ( object-key)( : )(reserved word )

            Regex.match?(~r/(\s*"\w+")(\s*:\s*)({\s*)$/, line) -> # ( object-key)( : )({ )[end-of-line]

            Regex.match?(~r/(\s*"\w+")(\s*:\s*)(\[\s*)$/, line) -> # ( object-key)( : )([ )[end-of-line]

            Regex.match?(~r/^\s*[,:}\]]+\s*$/, line) -> # [start-of-line] punctuation [end-of-line]

            Regex.match?(~r/(\s*{)(\s*"\w+")(\s*:\s*)("\w+")(\s*,\s*)("\w+")(\s*:\s*)("\w+\(\)"\s*)(}\s*)/, line) -> # ( [)( string)( : )(string)( , )(string)( : )(string() )(] )

            Regex.match?(~r/(\s*"\w+")(\s*:\s*)("\w+\.\w+\s*=\s*\(\w+\.\w+\s*\/\s*\d+\)\s*\*\s*\d+;")\s*/, line) -> # ( object-key)( : )(string )

        end
    end

    def color(item, type) do
        case do

        end
    end
end