defmodule Mix.Tasks.GenDay do
  use Mix.Task

  alias Mix.Shell.IO, as: MixIO

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
  @output "lib/advent_of_code/"
  @test_folder "test/advent_of_code/"

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

    assigns = [
      day: day,
      year: year,
      module: "#{year_name}.Day#{padded_day}"
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

    # Create empty input file if session does not exist
    if is_nil(Application.get_env(:advent_of_code_helper, :session)) do
      MixIO.info(
        "Creating empty input file because :session is not set in :advent_of_code_helper config"
      )

      Application.get_env(:advent_of_code_helper, :cache_dir)
      |> Path.join("input_#{year}_#{day}")
      |> Mix.Generator.create_file("")
    end
  end
end
