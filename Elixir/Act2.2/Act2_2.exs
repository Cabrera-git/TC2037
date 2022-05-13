# Actividad 2.2
# 
# Emiliano Cabrera - A01025453
# Do Hyun Nam - A01025276
# 2022-05-03

# 1.- Insert.insert(n,lst) ingresa un elemento n dentro de una lista ordenada lst

defmodule Insert do
    def insert(n,lst) do
        List.insert_at(lst,Insert.insert_counter(n,lst),n)
    end

    def insert_counter(n,lst,c \\ 0) do
        cond do
            n > List.first(lst) ->
                Insert.insert_counter(n,tl(lst),c+1)
            n <= List.first(lst) ->
                c
        end
    end
end

IO.inspect(Insert.insert(4,[1,2,3,7,8,16]))

# 2.- Sort.insertion_sort(lst) regresa una lista nueva con los elementos de lst ordenados de manera ascendente

defmodule Sort do
    def insertion_sort(lst) do
        Sort.insert_sort(lst,Sort.size(lst),[hd(lst)])
    end

    def size(lst,c \\ 0) do
        unless [] == lst do
            Sort.size(tl(lst),c+1)
        else
            c
        end
    end

    def insert_sort(lst,c,lst1) do
        unless c == 0 do
            Sort.insert_sort(tl(lst),c-1,Insert.insert(hd(lst),lst1))
        else
            lst1
        end
    end
end

IO.inspect(Sort.insertion_sort([25,234,65,67,2,3]))

# 3.- Rotate.rotate_left(n,lst) mueve los elementos de una lista lst un número n de espacios hacia la izquierda, si n es negativo los mueve a la derecha

defmodule Rotate do
    def rotate_left(n,lst) do
        cond do
            n < 0 ->
                Rotate.rotate_left(Sort.size(lst)+n,lst)
            n > 0 ->
                [h | t] = lst
                lst1 = t ++ [h]
                Rotate.rotate_left(n-1,lst1)
            n == 0 ->
                lst
            [] == lst ->
                lst
        end
    end
end


IO.inspect(Rotate.rotate_left(3,[1,2,3,4,5,6,7,8,9,0]))
IO.inspect(Rotate.rotate_left(-3,[1,2,3,4,5,6,7,8,9,0]))

# 10.- 
defmodule Encode do
    def encode([]), do: []
  def encode(list), do: do_encode(list, nil, 0, []) # nil es null

  defp do_encode([], prev, n, build), do: Enum.reverse([{n, prev} | build])   #return=build prev=hdp
  defp do_encode([head | tail], prev, n, build) do
    if head == prev do
      do_encode(tail, prev, n + 1, build)
    else
      if prev == nil do
        do_encode(tail, head, 1, build)
      else
        do_encode(tail, head, 1, [{n, prev} | build])
      end
    end
  end
end

  IO.inspect(Encode.encode([]))
  IO.inspect(Encode.encode([1,1,2,3,3,3,4,4,5,6,7,5,6,1]))