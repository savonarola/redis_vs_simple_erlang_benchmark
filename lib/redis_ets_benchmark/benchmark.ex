defmodule RedisEtsBenchmark.Benchmark do
  @wait_threshold 1000

  def run(init_fn, fun, time, parallel \\ 1) do
    1..parallel
    |> Enum.map(fn(_) -> Task.async(fn -> do_benchmark(init_fn, fun, time) end) end)
    |> Enum.map(fn(pid) -> Task.await(pid, time + @wait_threshold) end)
    |> sum()
    |> calc_stats()
  end

  defp sum(run_results) do
    Enum.reduce(run_results, {0,0,0},
      fn({cnt, time, time_sq}, {total_cnt, total_time, total_time_sq}) ->
        {total_cnt + cnt, total_time + time, total_time_sq + time_sq}
      end
    )
  end

  defp calc_stats({0, _, _}), do: {0, 0, 0}
  defp calc_stats({cnt, total_time, total_time_sq}) do
    mean = total_time / cnt
    mean_sq = total_time_sq / cnt
    stdev = :math.sqrt(mean_sq - mean * mean)
    {cnt, mean, stdev}
  end

  defp do_benchmark(init_fn, fun, time) do
    st = init_fn.()
    fun_with_st = fn -> fun.(st) end
    do_benchmark_iter(fun_with_st, :erlang.monotonic_time(:milli_seconds) + time, {0,0,0})
  end

  defp do_benchmark_iter(fun, deadline, {cnt, total_time, total_time_sq} = stat) do
    if :erlang.monotonic_time(:milli_seconds) > deadline do
      stat
    else
      {time_micro, _} = :timer.tc(fun)
      time = time_micro / 1_000
      do_benchmark_iter(fun, deadline, {cnt + 1, total_time + time, total_time_sq + time * time})
    end
  end

end
