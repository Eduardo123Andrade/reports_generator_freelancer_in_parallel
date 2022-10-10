defmodule ReportsGeneratorInParallel.Parser do
  @index_for_hours_worked 1
  @index_for_years 4

  def parse_file(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_line(line),
    do:
      line
      |> String.split(",")
      |> Enum.map(&String.trim/1)
      |> List.update_at(@index_for_hours_worked, &String.to_integer/1)
      |> List.update_at(@index_for_years, &String.to_integer/1)
end
