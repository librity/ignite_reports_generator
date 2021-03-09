defmodule ReportsGenerator do
  def build(filename) do
    "data/#{filename}.csv"
    |> File.stream!()
    # |> IO.inspect()
    |> handle_file_read()
    |> parse_content()
  end

  defp handle_file_read({:ok, content}), do: content
  defp handle_file_read({:error, _reason}), do: "Error: file not found."

  defp parse_content(content) do
    content
    |> String.split("\n")
    # |> Stream.map(fn line -> String.split(line, ",") end)
    |> Enum.map(fn line -> String.split(line, ",") end)
  end
end
