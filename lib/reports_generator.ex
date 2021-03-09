defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

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

  defp previous_or_zero(nil), do: 0
  defp previous_or_zero(number), do: number

  defp fetch_greatest_buyer(%{"users" => users, "food_items" => _food_items}),
    do: Enum.max_by(users, fn {_key, value} -> value end)

  defp fetch_top_seller(%{"users" => _users, "food_items" => food_items}),
    do: Enum.max_by(food_items, fn {_key, value} -> value end)
end
