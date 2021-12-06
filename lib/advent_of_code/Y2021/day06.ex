defmodule AdventOfCode.Y2021.Day06 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2021/day/6
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> simulate_days()
    |> length()
  end

  def simulate_days(fish, days \\ 80)

  def simulate_days(fish, 0), do: fish

  def simulate_days(fish, days) do
    Enum.reduce(fish, [], fn
      0, acc -> [8, 6 | acc]
      f, acc -> [f - 1 | acc]
    end)
    |> simulate_days(days - 1)
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    nr_map = 0..8 |> Enum.map(fn nr -> {nr, 0} end) |> Map.new()

    prep_input(input)
    |> Enum.reduce(nr_map, fn days, acc ->
      %{^days => val} = acc
      %{acc | days => val + 1}
    end)
    |> simulate_days_optimized()
    |> Map.values()
    |> Enum.sum()
  end

  def simulate_days_optimized(fish, days \\ 256)

  def simulate_days_optimized(fish, 0), do: fish

  def simulate_days_optimized(fish, days) do
    iterate_fish_list(fish)
    |> simulate_days_optimized(days - 1)
  end

  def iterate_fish_list(fish) do
    {zero_days, rest} = Map.pop(fish, 0)

    new_fish =
      rest
      |> Enum.map(fn {day, val} -> {day - 1, val} end)
      |> Map.new()
      |> Map.put_new(0, 0)
      |> Map.put_new(8, zero_days)

    %{6 => six} = new_fish
    %{new_fish | 6 => six + zero_days}
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 6)
    content
  end
end
