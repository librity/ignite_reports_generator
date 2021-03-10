# ReportsGenerator

A simple module that calculates the size of a list with tail-call-optimized
recursion.

## Commands

```bash
$ mix deps.get
$ mix credo gen.config
$ mix credo
$ mix credo --strict
$ mix test
$ mix test test/reports_generator/parser_test.exs
$ mix test test/reports_generator/parser_test.exs:7
```

```elixir
> "Foo" <> "bar"
"Foobar"
> [1, 2, 3] ++ [2, 3, 4]
[1, 2, 3, 2, 3, 4]

> Enum.reduce([1, 2, 3, 4], 0, fn element, accumulator -> element + accumulator end)
10
> Enum.reduce([1, 2, 3, 4], %{}, fn element, accumulator -> IO.inspect(element); IO.inspect(accumulator); Map.put(accumulator, element, element) end)
1
%{}
2
%{1 => 1}
3
%{1 => 1, 2 => 2}
4
%{1 => 1, 2 => 2, 3 => 3}
%{1 => 1, 2 => 2, 3 => 3, 4 => 4}

> Enum.into(1..5, %{}, fn number -> {Integer.to_string(number), 0} end)
%{"1" => 0, "2" => 0, "3" => 0, "4" => 0, "5" => 0}
> Enum.into(1..5, %{}, &{Integer.to_string(&1), 0})
%{"1" => 0, "2" => 0, "3" => 0, "4" => 0, "5" => 0}

> %{"1" => 278849, "2" => 2, "3" => 65} |> Enum.max_by(fn {_key, value} -> value end)
{"1", 278849}
```

Using Erlang modules:

```elixir
# Measure the execution time of a function in microseconds:
> :timer.tc(fn -> ReportsGenerator.build("report_complete") end)
{920_548, :FUNCTION_RETURN}
# microsecond / 1000000 = seconds
> :timer.tc(fn -> ReportsGenerator.build_from_many(["report_1", "report_2", "report_3"]) end)
{249_578, :FUNCTION_RETURN}
```

Messing with processes:

```elixir
# Execute function in a separate process
> pid = spawn fn -> IO.puts("banana") end
banana
#PID<0.206.0>
> Process.alive?(pid)
false

> self()
#PID<0.203.0>
> Process.alive?(self())
true

# Send a message to a process
> send self(), {:ok, "Success!"}
{:ok, "Success!"}
> receive do
{:ok, message} -> message
{:error, _message} -> "FUBAR"
end
"Success!"

> send self(), {:error, "ERROR"}
{:error, "ERROR"}
> receive do
{:ok, message} -> message
{:error, _message} -> "FUBAR"
end
"FUBAR"

> self_id = self()
> spawn(fn -> send(self_id, {:ok, "Did it work?"}) end)
> receive do
{:ok, message} -> message
{:error, _message} -> "FUBAR"
end
"Did it work?"
```

## Resources

- https://github.com/rrrene/credo
- https://dev.to/dnovais/aridade-de-uma-funcao-41mo
- https://github.com/Microsoft/vscode-docs/blob/vnext/release-notes/v1_9.md#control-the-dimensions-of-new-windows
- https://github.com/christopheradams/elixir_style_guide
- https://hexdocs.pm/elixir/master/Task.html

Recompile error:

- https://app.rocketseat.com.br/h/forum/elixir/b0d85d7b-a2f1-4024-aa61-7fcc73a537be
- https://github.com/iampeterbanjo/vscode-elixir-linter/issues/25
- https://github.com/JakeBecker/elixir-ls/issues/93
