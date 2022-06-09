# Actividad 5.2
# 
# Emiliano Cabrera - A01025453
# Do Hyun Nam - A01025276
# 2022-05-20

defmodule Hw.Primes do

    def timer(function) do
        function
        |> :timer.tc()
        |> elem(0)
        |> Kernel./(1_000_000)
    end

    def sum_primes(lim, current \\ 2, sum \\ 0) do
        cond do
            current >= lim ->
                if prime?(current) do
                    sum+current
                else
                    sum
                end
            prime?(current) ->
                sum_primes(lim,current+1,sum+current)
            !prime?(current) ->
                sum_primes(lim,current+1,sum)
        end
    end

    def sum_primes_parallel(lim, thr) do
        primeLst = primeBin(lim)
        primeSize = Kernel.length(primeLst)

        primeLst
        |> Enum.chunk_every(Kernel.div(primeSize,thr))
        |> Enum.map(&Task.async(fn -> Enum.sum(&1) end))
        |> Enum.map(&Task.await(&1))
        |> Enum.sum()
    end

    defp prime?(n, i \\ 2) do
        cond do
            n == 2 ->
                true
            n < 2 ->
                false
            Kernel.rem(n,i) == 0 -> 
                false
            i >= :math.sqrt(n) ->
                true
            true ->
                prime?(n,i+1)
        end
    end

    defp primeBin(finish, current \\ 1, lst \\ []) do
        cond do
            current >= finish ->
                lst
            prime?(current) ->
                primeBin(finish,current+1,[current | lst])
            !prime?(current) ->
                primeBin(finish,current+1,lst)
        end        
    end
end

IO.puts("Convencional")
IO.puts(Hw.Primes.sum_primes(5000000))
IO.puts(Hw.Primes.timer(fn -> Hw.Primes.sum_primes(5000000) end))
IO.puts("\nParalelo")
IO.puts(Hw.Primes.sum_primes_parallel(5000000,8))
IO.puts(Hw.Primes.timer(fn -> Hw.Primes.sum_primes_parallel(5000000,8) end))