# Actividad 5.2
# 
# Emiliano Cabrera - A01025453
# Do Hyun Nam - A01025276
# 2022-05-20

defmodule Hw.Primes do
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

    # def sum_primes_parallel(lim, thr) do
    #     bin_size = Kernel.div(lim,thr)

    #     1..thr
    #     |> Enum.map(&Task.async(fn -> parallel_sum(bin_size) end))
    #     |> Enum.map(&Task.await(&1))
    #     |> Enum.sum()
    #     |> IO.inspect()
    # end

    def parallel_sum(low,upp) do
        Enum.to_list(low,upp) 
        |> (fn x -> 
                if !prime?(x) do 
                    List.delete(x)
                end
            end)
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
end

# IO.inspect(Hw.Primes.sum_primes(5000000))
IO.inspect(Hw.Primes.parallel_sum(1,10))