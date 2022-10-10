defmodule ReportsGeneratorInParallelTest do
  use ExUnit.Case

  describe "build/1" do
    test "when a file list is provided, builds the report" do
      filenames = ["part_1_test.txt", "part_1_test.txt"]

      response = ReportsGeneratorInParallel.build(filenames)

      expected_response = {
        :ok,
        %{
          "all_hours" => %{
            "Cleiton" => 8,
            "Daniele" => 42,
            "Danilo" => 0,
            "Diego" => 0,
            "Giuliano" => 20,
            "Jakeliny" => 28,
            "Joseph" => 6,
            "Mayk" => 10,
            "Rafael" => 0,
            "Vinicius" => 0
          },
          "hours_per_month" => %{
            "Cleiton" => %{
              "Abril" => 0,
              "Agosto" => 0,
              "Dezembro" => 0,
              "Fevereiro" => 0,
              "Janeiro" => 0,
              "Julho" => 0,
              "Junho" => 8,
              "Maio" => 0,
              "Março" => 0,
              "Novembro" => 0,
              "Outubro" => 0,
              "Setembro" => 0
            },
            "Daniele" => %{
              "Abril" => 14,
              "Agosto" => 0,
              "Dezembro" => 10,
              "Fevereiro" => 0,
              "Janeiro" => 0,
              "Julho" => 0,
              "Junho" => 2,
              "Maio" => 16,
              "Março" => 0,
              "Novembro" => 0,
              "Outubro" => 0,
              "Setembro" => 0
            },
            "Danilo" => %{
              "Abril" => 0,
              "Agosto" => 0,
              "Dezembro" => 0,
              "Fevereiro" => 0,
              "Janeiro" => 0,
              "Julho" => 0,
              "Junho" => 0,
              "Maio" => 0,
              "Março" => 0,
              "Novembro" => 0,
              "Outubro" => 0,
              "Setembro" => 0
            },
            "Diego" => %{
              "Abril" => 0,
              "Agosto" => 0,
              "Dezembro" => 0,
              "Fevereiro" => 0,
              "Janeiro" => 0,
              "Julho" => 0,
              "Junho" => 0,
              "Maio" => 0,
              "Março" => 0,
              "Novembro" => 0,
              "Outubro" => 0,
              "Setembro" => 0
            },
            "Giuliano" => %{
              "Abril" => 2,
              "Agosto" => 0,
              "Dezembro" => 0,
              "Fevereiro" => 18,
              "Janeiro" => 0,
              "Julho" => 0,
              "Junho" => 0,
              "Maio" => 0,
              "Março" => 0,
              "Novembro" => 0,
              "Outubro" => 0,
              "Setembro" => 0
            },
            "Jakeliny" => %{
              "Abril" => 0,
              "Agosto" => 0,
              "Dezembro" => 0,
              "Fevereiro" => 0,
              "Janeiro" => 0,
              "Julho" => 16,
              "Junho" => 0,
              "Maio" => 0,
              "Março" => 12,
              "Novembro" => 0,
              "Outubro" => 0,
              "Setembro" => 0
            },
            "Joseph" => %{
              "Abril" => 0,
              "Agosto" => 0,
              "Dezembro" => 0,
              "Fevereiro" => 0,
              "Janeiro" => 0,
              "Julho" => 0,
              "Junho" => 0,
              "Maio" => 0,
              "Março" => 6,
              "Novembro" => 0,
              "Outubro" => 0,
              "Setembro" => 0
            },
            "Mayk" => %{
              "Abril" => 0,
              "Agosto" => 0,
              "Dezembro" => 10,
              "Fevereiro" => 0,
              "Janeiro" => 0,
              "Julho" => 0,
              "Junho" => 0,
              "Maio" => 0,
              "Março" => 0,
              "Novembro" => 0,
              "Outubro" => 0,
              "Setembro" => 0
            },
            "Rafael" => %{
              "Abril" => 0,
              "Agosto" => 0,
              "Dezembro" => 0,
              "Fevereiro" => 0,
              "Janeiro" => 0,
              "Julho" => 0,
              "Junho" => 0,
              "Maio" => 0,
              "Março" => 0,
              "Novembro" => 0,
              "Outubro" => 0,
              "Setembro" => 0
            },
            "Vinicius" => %{
              "Abril" => 0,
              "Agosto" => 0,
              "Dezembro" => 0,
              "Fevereiro" => 0,
              "Janeiro" => 0,
              "Julho" => 0,
              "Junho" => 0,
              "Maio" => 0,
              "Março" => 0,
              "Novembro" => 0,
              "Outubro" => 0,
              "Setembro" => 0
            }
          },
          "hours_per_year" => %{
            "Cleiton" => %{2016 => 6, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 2},
            "Daniele" => %{2016 => 20, 2017 => 6, 2018 => 14, 2019 => 0, 2020 => 2},
            "Danilo" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 0},
            "Diego" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 0},
            "Giuliano" => %{2016 => 0, 2017 => 6, 2018 => 0, 2019 => 12, 2020 => 2},
            "Jakeliny" => %{2016 => 0, 2017 => 16, 2018 => 0, 2019 => 12, 2020 => 0},
            "Joseph" => %{2016 => 0, 2017 => 6, 2018 => 0, 2019 => 0, 2020 => 0},
            "Mayk" => %{2016 => 0, 2017 => 2, 2018 => 0, 2019 => 8, 2020 => 0},
            "Rafael" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 0},
            "Vinicius" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 0}
          }
        }
      }

      assert response == expected_response
    end
  end

  describe "build/0" do
    test "when filename isn't provider throw an erro" do
      {_, response} = ReportsGeneratorInParallel.build()

      expected_response = "Please, provide the list of filename"

      assert response == expected_response
    end
  end
end
