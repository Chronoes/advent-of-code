defmodule AdventOfCode.Y2021.Day07 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2021/day/7
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
    crabs = prep_input(input)
    max_fuel = Enum.max(crabs)

    Enum.map(0..max_fuel, fn pos ->
      Enum.map(crabs, fn crab -> abs(crab - pos) end)
      |> Enum.sum()
    end)
    |> Enum.min()
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    crabs = prep_input(input)
    max_fuel = Enum.max(crabs)

    Enum.map(0..max_fuel, fn pos ->
      Enum.map(crabs, fn crab ->
        moved = abs(crab - pos)
        trunc(moved * (1 + (moved - 1) / 2))
      end)
      |> Enum.sum()
    end)
    |> Enum.min()
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 7)
    content
  end
end
