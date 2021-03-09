defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @fields ["users", "food_items"]

  def build(filename) do
    Parser.call(filename)
    |> Enum.reduce(initialize_report(), &accumulate_fields/2)
  end

  defp initialize_report, do: %{"users" => %{}, "food_items" => %{}}

  defp accumulate_fields(line, %{"users" => users, "food_items" => food_items} = report) do
    users = accumulate_users(line, users)
    food_items = accumulate_food_items(line, food_items)

    %{report | "users" => users, "food_items" => food_items}
  end

  defp accumulate_users([user_id, _item_name, price], users) do
    previous = previous_or_zero(users[user_id])
    Map.put(users, user_id, previous + price)
  end

  defp accumulate_food_items([_user_id, item_name, _price], food_items) do
    previous = previous_or_zero(food_items[item_name])
    Map.put(food_items, item_name, previous + 1)
  end

  defp previous_or_zero(map_value) when is_nil(map_value), do: 0
  defp previous_or_zero(map_value) when is_number(map_value), do: map_value

  defp fetch_max_from_field(report, field) when field in @fields do
    {:ok, Enum.max_by(report[field], fn {_key, value} -> value end)}
  end

  defp fetch_max_from_field(_report, _field), do: {:error, "Invalid field."}
end
