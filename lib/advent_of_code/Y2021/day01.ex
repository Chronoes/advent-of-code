defmodule AdventOfCode.Y2021.Day01 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2021/day/1
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
    prep_input(input)
    |> increased_depths(0)
  end

  def increased_depths([a, b | depths], sum) do
    increased_depths(
      [b | depths],
      if b > a do
        sum + 1
      else
        sum
      end
    )
  end

  def increased_depths([_], sum), do: sum

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> make_sliding_windows()
    |> increased_depths(0)
  end

  def make_sliding_windows(depths) when length(depths) >= 3 do
    [Enum.take(depths, 3) |> Enum.sum() | make_sliding_windows(Enum.drop(depths, 1))]
  end

  def make_sliding_windows(_), do: []

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 1)
    content
  end
end
