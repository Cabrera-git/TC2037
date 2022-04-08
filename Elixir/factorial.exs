defmodule Factorial do
  def tail_recursive_factorial(n), do: tail_recursive_factorial(n, 1)
  defp tail_recursive_factorial(0, acc), do: acc
  defp tail_recursive_factorial(n, acc), do: tail_recursive_factorial(n-1, acc*n)
end
