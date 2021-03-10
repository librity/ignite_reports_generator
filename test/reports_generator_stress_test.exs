defmodule ReportsGeneratorStressTest do
  use ExUnit.Case

  describe "build/1" do
    test "should build and return a report from a large .csv file" do
      file_name = "report_complete"
      return = ReportsGenerator.build(file_name)

      expected = %{
        "food_items" => %{
          "açaí" => 37_742,
          "churrasco" => 37_650,
          "esfirra" => 37_462,
          "hambúrguer" => 37_577,
          "pizza" => 37_365,
          "pastel" => 37_392,
          "prato_feito" => 37_519,
          "sushi" => 37_293
        },
        "users" => %{
          "1" => 278_849,
          "10" => 268_317,
          "2" => 271_031,
          "3" => 272_250,
          "4" => 277_054,
          "5" => 270_926,
          "6" => 272_053,
          "7" => 273_112,
          "8" => 275_161,
          "9" => 274_003,
          "11" => 268_877,
          "12" => 276_306,
          "13" => 282_953,
          "14" => 277_084,
          "15" => 280_105,
          "16" => 271_831,
          "17" => 272_883,
          "18" => 271_421,
          "19" => 277_720,
          "20" => 273_446,
          "21" => 275_026,
          "22" => 278_025,
          "23" => 276_523,
          "24" => 274_481,
          "25" => 274_512,
          "26" => 274_199,
          "27" => 278_001,
          "28" => 274_256,
          "29" => 273_030,
          "30" => 275_978
        }
      }

      assert expected == return
    end
  end

  describe "build_from_many/1" do
    test "should build and return a report from multiple .csv files" do
      file_name = ["report_1", "report_2", "report_3"]
      return = ReportsGenerator.build_from_many(file_name)

      expected =
        {:ok,
         %{
           "food_items" => %{
             "açaí" => 37_742,
             "churrasco" => 37_650,
             "esfirra" => 37_462,
             "hambúrguer" => 37_577,
             "pizza" => 37_365,
             "pastel" => 37_392,
             "prato_feito" => 37_519,
             "sushi" => 37_293
           },
           "users" => %{
             "1" => 278_849,
             "10" => 268_317,
             "2" => 271_031,
             "3" => 272_250,
             "4" => 277_054,
             "5" => 270_926,
             "6" => 272_053,
             "7" => 273_112,
             "8" => 275_161,
             "9" => 274_003,
             "11" => 268_877,
             "12" => 276_306,
             "13" => 282_953,
             "14" => 277_084,
             "15" => 280_105,
             "16" => 271_831,
             "17" => 272_883,
             "18" => 271_421,
             "19" => 277_720,
             "20" => 273_446,
             "21" => 275_026,
             "22" => 278_025,
             "23" => 276_523,
             "24" => 274_481,
             "25" => 274_512,
             "26" => 274_199,
             "27" => 278_001,
             "28" => 274_256,
             "29" => 273_030,
             "30" => 275_978
           }
         }}

      assert expected == return
    end
  end
end
