defmodule ReportsGenerator do
  def build(filename) do
    case File.read("data/#{filename}.csv") do
      {:ok, content} -> parse_content(content)
      {:error, reason} -> reason
    end
  end

  defp parse_content(content) do
    content
    |> String.split("\n")
    # |> Stream.map(fn line -> String.split(line, ",") end)
    |> Enum.map(fn line -> String.split(line, ",") end)
  end
end
