defmodule AdventOfCode.Y2022.Day01 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2022/day/1
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> calc_sum_of_calories()
    |> Enum.max()
  end

  def calc_sum_of_calories(elves) do
    elves
    |> Enum.map(fn inventory ->
      String.split(inventory, "\n")
      |> Enum.map(fn line -> Integer.parse(line) |> elem(0) end)
      |> Enum.sum()
    end)
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> calc_sum_of_calories()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 1)
    content
  end
end
