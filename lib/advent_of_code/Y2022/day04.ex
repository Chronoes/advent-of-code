defmodule AdventOfCode.Y2022.Day04 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2022/day/4
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, ",")
      |> Enum.map(fn elf -> String.split(elf, "-") |> Enum.map(&elem(Integer.parse(&1), 0)) end)
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.reduce(0, &(has_fully_contained_range_pair(&1) + &2))
  end

  def has_fully_contained_range_pair([[a1, b1], [a2, b2]]) do
    if (a1 <= a2 and b1 >= b2) or (a2 <= a1 and b2 >= b1), do: 1, else: 0
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> Enum.reduce(0, &(has_overlapping_range_pair(&1) + &2))
  end

  def has_overlapping_range_pair([[a1, b1], [a2, _b2]]) when a1 < a2, do: (b1 >= a2 && 1) || 0
  def has_overlapping_range_pair([[a1, _b1], [_a2, b2]]), do: (b2 >= a1 && 1) || 0

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 4)
    content
  end
end
