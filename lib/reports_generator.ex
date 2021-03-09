defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  def build(filename) do
    Parser.call(filename)
    |> Enum.reduce(%{}, &add_to_previous/2)
  end

  defp add_to_previous([id, _item_name, price], report) do
    previous = previous_or_zero(report[id])
    Map.put(report, id, previous + price)
  end

  defp previous_or_zero(nil), do: 0
  defp previous_or_zero(number), do: number
end
