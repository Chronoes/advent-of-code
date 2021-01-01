defmodule Mix.Tasks.GenDay do
  use Mix.Task

  @shortdoc "Generate a day boilerplate"
  @moduledoc """
  Basic usage generates day boilerplate for "current" year and day.
  ```
  mix gen_day
  ```
  "Current" year can be this or last year depending on current month according to UTC.
  E.g. if UTC date is 2020-04-13, `mix gen_day` will generate Day 13 for Year 2019

  If generating for different days, specify day and year
  ```
  # day 6 and current year
  mix gen_day 6
  # day and year
  mix gen_day 10 2017
  ```
  """

  @template "priv/templates/day.eex"
  @test_template "priv/templates/day_test.eex"
  @inputs_folder "priv/inputs"
  @output "lib/"
  @test_folder "test/"

  def run([day]) do
    year = to_string(AdventOfCode.get_current_year())
    create_file(day, year)
  end

  def run([day, year]), do: create_file(day, year)

  def run(_args) do
    today = Date.utc_today()
    run([to_string(today.day), to_string(AdventOfCode.get_current_year(today))])
  end

  defp create_file(day, year) do
    padded_day = String.pad_leading(day, 2, "0")
    year_name = "Y#{year}"

    input_path =
      @inputs_folder
      |> Path.join(year_name)
      |> Path.join("day" <> padded_day <> ".txt")

    assigns = [
      day: day,
      year: year,
      module: "#{year_name}.Day#{padded_day}",
      input_path: input_path
    ]

    # Create main solving file
    @output
    |> Path.join(year_name)
    |> Path.join("day" <> padded_day <> ".ex")
    |> Mix.Generator.create_file(EEx.eval_file(@template, assigns: assigns))

    # Create unit test file
    @test_folder
    |> Path.join(year_name)
    |> Path.join("day" <> padded_day <> "_test.exs")
    |> Mix.Generator.create_file(EEx.eval_file(@test_template, assigns: assigns))

    # Create empty input file
    Mix.Generator.create_file(input_path, "")
  end
end
