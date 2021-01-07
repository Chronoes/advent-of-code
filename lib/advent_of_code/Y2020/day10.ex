defmodule AdventOfCode.Y2020.Day10 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/10
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    {_, joltd1, _joltd2, joltd3} =
      prep_input(input)
      |> Enum.sort()
      |> Enum.reduce({0, [], [], []}, fn adapter, {acc, joltd1, joltd2, joltd3} ->
        case adapter - acc do
          1 -> {adapter, [adapter | joltd1], joltd2, joltd3}
          2 -> {adapter, joltd1, [adapter | joltd2], joltd3}
          3 -> {adapter, joltd1, joltd2, [adapter | joltd3]}
          _ -> {adapter, joltd1, joltd2, joltd3}
        end
      end)

    length(joltd1) * (length(joltd3) + 1)
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    adapters = prep_input(input)

    [0, Enum.max(adapters) + 3 | adapters]
    |> Enum.sort()
    |> calc_possible_paths()
  end

  def calc_possible_paths(adapters) do
    calc_possible_paths(adapters, [1])
  end

  defp calc_possible_paths(adapters, paths) when length(paths) === length(adapters),
    do: hd(paths)

  defp calc_possible_paths(adapters, paths) do
    idx = length(paths)

    result =
      1..3
      |> Enum.filter(fn j ->
        idx - j >= 0 and Enum.at(adapters, idx) - Enum.at(adapters, idx - j) <= 3
      end)
      |> Enum.map(&Enum.at(paths, &1 - 1))
      |> Enum.sum()

    calc_possible_paths(adapters, [result | paths])
  end

  @impl true
  def read_input do
    File.read!("priv/inputs/Y2020/day10.txt")
  end
end
