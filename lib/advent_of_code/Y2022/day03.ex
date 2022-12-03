defmodule AdventOfCode.Y2022.Day03 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2022/day/3
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&Enum.split(&1, Integer.floor_div(length(&1), 2)))
    |> Enum.flat_map(fn {a, b} ->
      MapSet.new(a)
      |> MapSet.intersection(MapSet.new(b))
      |> Enum.map(&get_char_priority/1)
    end)
    |> Enum.sum()
  end

  def get_char_priority(c) when c >= ?a, do: c - ?a + 1
  def get_char_priority(c), do: c - ?A + 27

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> Enum.chunk_every(3)
    |> Enum.flat_map(fn group ->
      group
      |> Enum.map(&String.to_charlist/1)
      |> Enum.map(&MapSet.new/1)
      |> Enum.reduce(&MapSet.intersection/2)
      |> Enum.map(&get_char_priority/1)
    end)
    |> Enum.sum()
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 3)
    content
  end
end
