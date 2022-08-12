#---
# Excerpted from "Programming Phoenix 1.4",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix14 for more book information.
#---
defmodule InfoSys do

  @backends [InfoSys.Wolfram]

  defmodule Result do
    defstruct score: 0, text: nil, backend: nil
  end

  def compute(query, opts \\ []) do
    timeout = opts[:timeout] || 10_000 
    opts = Keyword.put_new(opts, :limit, 10)
    backends = opts[:backends] || @backends

    backends
    |> Enum.map(&async_query(&1, query, opts))
    |> Task.yield_many(timeout) 
    |> Enum.map(fn {task, res} -> res || Task.shutdown(task, :brutal_kill) end) 
    |> Enum.flat_map(fn
      {:ok, results} -> results
      _ -> []
    end)
    |> Enum.sort(&(&1.score >= &2.score))
    |> Enum.take(opts[:limit])
  end

  defp async_query(backend, query, opts) do 
    Task.Supervisor.async_nolink(InfoSys.TaskSupervisor, 
      backend, :compute, [query, opts], shutdown: :brutal_kill
    )
  end
end
