defmodule ReportsGeneratorInParallel do
  alias ReportsGeneratorInParallel.Parser

  @months %{
    "1" => "Janeiro",
    "2" => "Fevereiro",
    "3" => "Março",
    "4" => "Abril",
    "5" => "Maio",
    "6" => "Junho",
    "7" => "Julho",
    "8" => "Agosto",
    "9" => "Setembro",
    "10" => "Outubro",
    "11" => "Novembro",
    "12" => "Dezembro"
  }

  @hours_per_month %{
    "Janeiro" => 0,
    "Fevereiro" => 0,
    "Março" => 0,
    "Abril" => 0,
    "Maio" => 0,
    "Junho" => 0,
    "Julho" => 0,
    "Agosto" => 0,
    "Setembro" => 0,
    "Outubro" => 0,
    "Novembro" => 0,
    "Dezembro" => 0
  }

  @years %{
    2016 => 0,
    2017 => 0,
    2018 => 0,
    2019 => 0,
    2020 => 0
  }

  def build(filenames) when not is_list(filenames),
    do: {:error, "Please provide a list of string"}

  def build(filenames) do
    report =
      filenames
      |> Task.async_stream(&generate_map_from_list/1)
      |> Enum.reduce(generate_initial_report_data(), &on_sum_reports/2)

    {:ok, report}
  end

  def build(), do: {:error, "Please, provide the list of filename"}

  defp on_sum_reports({:ok, result}, report), do: sum_reports(result, report)

  defp sum_reports(result, report) do
    all_hours = merge_maps(result["all_hours"], report["all_hours"])
    hours_per_month = merge_maps(result["hours_per_month"], report["hours_per_month"])
    hours_per_year = merge_maps(result["hours_per_year"], report["hours_per_year"])

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp merge_maps(map1, map2),
    do: Map.merge(map1, map2, &sum_values_from_merge/3)

  defp sum_values_from_merge(_key, value1, value2) when is_map(value1),
    do: Map.merge(value1, value2, &sum_values_from_merge/3)

  defp sum_values_from_merge(_key, value1, value2), do: value1 + value2

  defp generate_map_from_list(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(
      generate_initial_report_data(),
      &reduce/2
    )
  end

  defp reduce(list, accumulator) do
    [name, hour_per_work, _day, month, year] = list

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    } = accumulator

    all_hours = Map.put(all_hours, name, all_hours[name] + hour_per_work)

    hours_per_month =
      sum_worked_hours_in_period(hours_per_month, name, @months[month], hour_per_work)

    hours_per_year = sum_worked_hours_in_period(hours_per_year, name, year, hour_per_work)

    %{
      accumulator
      | "all_hours" => all_hours,
        "hours_per_month" => hours_per_month,
        "hours_per_year" => hours_per_year
    }
  end

  defp sum_worked_hours_in_period(map, first_key, second_key, hour_per_work) do
    current_hours_worked_in_period = map[first_key][second_key]

    updated_map =
      Map.put(
        map[first_key],
        second_key,
        current_hours_worked_in_period + hour_per_work
      )

    Map.put(map, first_key, updated_map)
  end

  defp generate_initial_report_data(),
    do: %{
      "all_hours" => %{
        "Daniele" => 0,
        "Mayk" => 0,
        "Giuliano" => 0,
        "Jakeliny" => 0,
        "Joseph" => 0,
        "Diego" => 0,
        "Danilo" => 0,
        "Cleiton" => 0,
        "Rafael" => 0,
        "Vinicius" => 0
      },
      "hours_per_month" => %{
        "Daniele" => @hours_per_month,
        "Mayk" => @hours_per_month,
        "Giuliano" => @hours_per_month,
        "Jakeliny" => @hours_per_month,
        "Joseph" => @hours_per_month,
        "Diego" => @hours_per_month,
        "Danilo" => @hours_per_month,
        "Cleiton" => @hours_per_month,
        "Rafael" => @hours_per_month,
        "Vinicius" => @hours_per_month
      },
      "hours_per_year" => %{
        "Daniele" => @years,
        "Mayk" => @years,
        "Giuliano" => @years,
        "Jakeliny" => @years,
        "Joseph" => @years,
        "Diego" => @years,
        "Danilo" => @years,
        "Cleiton" => @years,
        "Rafael" => @years,
        "Vinicius" => @years
      }
    }
end
