defmodule Mix.Tasks.Aoc.TestDay do
  use Mix.Task

  @shortdoc "Run unit tests for a day's module"
  @moduledoc """
  Basic usage runs unit tests for "current" year and day.
  ```
  mix aoc.test_day
  ```
  "Current" year is parsed in the same way as `mix aoc.gen_day`.

  If running tests for different days, specify day and year
  ```
  # day 6 and current year
  mix aoc.test_day 6
  # day and year
  mix aoc.test_day 10 2017
  ```

  See `mix help test` for more information
  """

  @impl Mix.Task
  def run(args) do
    {option_args, args} = Enum.split_with(args, fn arg -> String.starts_with?(arg, "-") end)
    {day, year} = Mix.Tasks.Aoc.GenDay.get_day_and_year(args)
    run_tests(day, year, option_args)
  end

  @spec test_folder :: binary()
  def test_folder, do: "test/advent_of_code/"

  def test_filename(day, year) do
    {day, year} = Mix.Tasks.Aoc.GenDay.to_module_components(day, year)
    Path.join([test_folder(), year, "day#{day}_test.exs"])
  end

  defp run_tests(day, year, option_args) do
    Mix.Task.run("test", option_args ++ [test_filename(day, year)])
  end
end
