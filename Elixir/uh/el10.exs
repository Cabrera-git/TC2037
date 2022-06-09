def encode([]), do: []
  def encode(list), do: do_encode(list, nil, 0, [])

  defp do_encode([], pre, n, construct), do: Enum.reverse([{n, pre} | construct])
  defp do_encode([cabeza | cola], pre, n, construct) do
    when cabeza == pre do
      do_encode(cabeza, cola, n + 1, construct)
    when != pre do
      if pre == nil do
        do_encode(cabeza, cola, 1, construct)
      else
        do_encode(cabeza, cola, 1, [{n, pre} | construct])
      end
    end
  end
