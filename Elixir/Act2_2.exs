# 1.- Insert.insert(n,lst) ingresa un elemento n dentro de una lista ordenada lst

defmodule Insert do
    def insert(n,lst) do
        List.insert_at(lst,Insert.insert_counter(n,lst,0),n)
    end

    def insert_counter(n,lst,c) do
        cond do
            n > List.first(lst) ->
                Insert.insert_counter(n,tl(lst),c+1)
            n < List.first(lst) ->
                c
        end
    end
end

IO.inspect(Insert.insert(4,[1,2,3,7,8,16]))

# 3.- Rotate.rotate_left(n,lst) mueve los elementos de una lista lst un número n de espacios hacia la izquierda, si n es negativo los mueve a la derecha

defmodule Rotate do
    def rotate_left(n,lst) do
        cond do
            n < 0 ->
                Rotate.rotate_left(Rotate.size(lst)+n,lst)
            n > 0 ->
                [h | t] = lst
                lst1 = t ++ [h]
                Rotate.rotate_left(n-1,lst1)
            0 = n ->
                lst
            [] = lst ->
                lst
        end
    end

    def size(lst,c \\ 0) do
        [h | t] = lst

        if [] = t
            c
        else
            Rotate.size(t,c+1)
        end
    end
end

IO.inspect(Rotate.rotate_left(3,[1,2,3,4,5,6,7,8,9,0]))
IO.inspect(Rotate.rotate_left(-3,[1,2,3,4,5,6,7,8,9,0]))