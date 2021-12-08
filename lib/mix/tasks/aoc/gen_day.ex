defmodule Mix.Tasks.Aoc.GenDay do
  use Mix.Task

  alias Mix.Shell.IO, as: MixIO

  @shortdoc "Generate a day boilerplate"
  @moduledoc """
  Basic usage generates day boilerplate for "current" year and day.
  ```
  mix aoc.gen_day
  ```
  "Current" year can be this or last year depending on current month according to UTC.
  E.g. if UTC date is 2020-04-13, `mix aoc.gen_day` will generate Day 13 for Year 2019

  If generating for different days, specify day and year
  ```
  # day 6 and current year
  mix aoc.gen_day 6
  # day and year
  mix aoc.gen_day 10 2017
  ```
  """

  @template "priv/templates/day.eex"
  @test_template "priv/templates/day_test.eex"
  @output "lib/advent_of_code/"

  @impl Mix.Task
  def run(args) do
    {day, year} = get_day_and_year(args)
    create_file(day, year)
  end

  @spec get_day_and_year(args :: [binary()]) :: {binary(), binary()}
  def get_day_and_year([day]) do
    year = to_string(AdventOfCode.get_current_year())
    {day, year}
  end

  def get_day_and_year([day, year]), do: {day, year}

  def get_day_and_year(_args) do
    today = Date.utc_today()
    {to_string(today.day), to_string(AdventOfCode.get_current_year(today))}
  end

  @spec to_module_components(binary, any) :: {binary, binary()}
  def to_module_components(day, year), do: {String.pad_leading(day, 2, "0"), "Y#{year}"}

  defp create_file(day, year) do
    {day_name, year_name} = to_module_components(day, year)

    assigns = [
      day: day,
      year: year,
      module: "#{year_name}.Day#{day_name}"
    ]

    # Create main solving file
    @output
    |> Path.join(year_name)
    |> Path.join("day#{day_name}.ex")
    |> Mix.Generator.create_file(EEx.eval_file(@template, assigns: assigns))

    # Create unit test file
    Mix.Tasks.Aoc.TestDay.test_filename(day, year)
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
