defmodule ReportsGenerator.ParserTest do
  use ExUnit.Case

  alias ReportsGenerator.Parser

  describe "call/1" do
    test "should read file and return a list of parsed contents" do
      file_name = "report_test"

      return =
        file_name
        |> Parser.call()
        |> Enum.map(& &1)

      expected = [
        ["1", "pizza", 48],
        ["2", "açaí", 45],
        ["3", "hambúrguer", 31],
        ["4", "esfirra", 42],
        ["5", "hambúrguer", 49],
        ["6", "esfirra", 18],
        ["7", "pizza", 27],
        ["8", "esfirra", 25],
        ["9", "churrasco", 24],
        ["10", "churrasco", 36]
      ]

      assert expected == return
    end
  end
end
