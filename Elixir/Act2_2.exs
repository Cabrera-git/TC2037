defmodule Insert do
    def insert(n,lst) do
        if n > hd(lst) do
            Insert.insert(n,tl(lst))
        end
        if n < hd(lst) do
            List.insert_at(lst,0,n)
        end
    end
end