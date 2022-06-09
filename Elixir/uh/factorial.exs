defmodule Learn
do

    def fact(x)
    do
        if x == 0
        do
            1
            else
                x * fact (x-1)
        end
    end
end

IO.puts(Learn.fact(5))
