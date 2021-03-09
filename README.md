# ReportsGenerator

A simple module that calculates the size of a list with tail-call-optimized
recursion.

## Commands

```bash
$ mix deps.get
$ mix credo gen.config
$ mix credo
$ mix credo --strict
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
```

## Resources

- https://github.com/rrrene/credo
- https://dev.to/dnovais/aridade-de-uma-funcao-41mo
- https://github.com/Microsoft/vscode-docs/blob/vnext/release-notes/v1_9.md#control-the-dimensions-of-new-windows

Recompile error:

- https://app.rocketseat.com.br/h/forum/elixir/b0d85d7b-a2f1-4024-aa61-7fcc73a537be
- https://github.com/iampeterbanjo/vscode-elixir-linter/issues/25
- https://github.com/JakeBecker/elixir-ls/issues/93
