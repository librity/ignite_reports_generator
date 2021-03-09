defmodule ReportsGenerator do
  def build(filename) do
    "data/#{filename}.csv"
    |> File.stream!()
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(0, &String.to_integer/1)
    |> List.update_at(2, &String.to_integer/1)
  end
end
