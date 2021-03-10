defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @fields ["users", "food_items"]

  def build_from_many(file_names) do
    file_names
    |> Task.async_stream(&build/1)
    |> Enum.reduce(initialize_report(), &merge_reports/2)
  end

  def build(file_name) do
    file_name
    |> Parser.call()
    |> Enum.reduce(initialize_report(), &accumulate_fields/2)
  end

  def fetch_max_from_field(report, field) when field in @fields do
    {:ok, Enum.max_by(report[field], fn {_key, value} -> value end)}
  end

  def fetch_max_from_field(_report, _field), do: {:error, "Invalid field."}

  defp merge_reports({:ok, partial}, report) do
    users = merge_users(partial, report)
    food_items = merge_food_items(partial, report)

    build_report(users, food_items)
  end

  defp merge_users(%{"users" => partial_users}, %{"users" => users}) do
    merge_by_value(partial_users, users)
  end

  defp merge_food_items(%{"food_items" => partial_food_items}, %{"food_items" => food_items}) do
    merge_by_value(partial_food_items, food_items)
  end

  defp merge_by_value(map_one, map_two) do
    Map.merge(map_one, map_two, fn _key, value_one, value_two -> value_one + value_two end)
  end

  defp accumulate_fields(line, %{"users" => users, "food_items" => food_items}) do
    users = accumulate_users(line, users)
    food_items = accumulate_food_items(line, food_items)

    build_report(users, food_items)
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

  defp initialize_report, do: %{"users" => %{}, "food_items" => %{}}
  defp build_report(users, food_items), do: %{"users" => users, "food_items" => food_items}
end
