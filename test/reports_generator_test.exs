defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "should build and return a report from a .csv file" do
      file_name = "report_test"
      return = ReportsGenerator.build(file_name)

      expected = %{
        "food_items" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pizza" => 2
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "2" => 45,
          "3" => 31,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert expected == return
    end
  end

  describe "fetch_max_from_field/2" do
    test "should return the greatest buyer from 'users'" do
      file_name = "report_test"
      field = "users"

      return =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_max_from_field(field)

      expected = {:ok, {"5", 49}}

      assert expected == return
    end

    test "should return the top seller from 'food_items'" do
      file_name = "report_test"
      field = "food_items"

      return =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_max_from_field(field)

      expected = {:ok, {"esfirra", 3}}

      assert expected == return
    end

    test "should return an :error when field isn't valid" do
      file_name = "report_test"
      field = "foobar"

      return =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_max_from_field(field)

      expected = {:error, "Invalid field."}

      assert expected == return
    end
  end
end
