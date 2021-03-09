defmodule ReportsGenerator do
  def build(filename) do
    "data/#{filename}.csv"
    |> File.stream!()
    |> Enum.reduce(%{}, &parse_and_add/2)
  end

  defp parse_and_add(line, report) do
    [id, _item_name, price] = parse_line(line)
    previous = previous_or_zero(report[id])
    Map.put(report, id, previous + price)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end

  defp previous_or_zero(nil), do: 0
  defp previous_or_zero(number), do: number
end
