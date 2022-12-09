defmodule AdventOfCode.Y2022.Day09 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2022/day/9
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      [dir, len] = String.split(line, " ", parts: 2)
      {dir, Integer.parse(len) |> elem(0)}
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.reduce({{0, 0}, {0, 0}, MapSet.new()}, fn item, {head_pos, tail_pos, tail_visited} ->
      traversed = parse_dir(item, head_pos)

      Enum.reduce(
        traversed,
        {head_pos, tail_pos, tail_visited},
        fn new_pos, {last_pos, tail_pos, visited} ->
          if is_adjacent?(new_pos, tail_pos) do
            {new_pos, tail_pos, MapSet.put(visited, tail_pos)}
          else
            {new_pos, last_pos, MapSet.put(visited, last_pos)}
          end
        end
      )
    end)
    |> elem(2)
    |> MapSet.size()
  end

  def parse_dir({"U", len}, {x, y}) do
    Enum.map(1..len, fn nr -> {x, y + nr} end)
  end

  def parse_dir({"R", len}, {x, y}) do
    Enum.map(1..len, fn nr -> {x + nr, y} end)
  end

  def parse_dir({"D", len}, {x, y}) do
    Enum.map(1..len, fn nr -> {x, y - nr} end)
  end

  def parse_dir({"L", len}, {x, y}) do
    Enum.map(1..len, fn nr -> {x - nr, y} end)
  end

  def is_adjacent?({x1, y1}, {x2, y2}) do
    (y1 - 1)..(y1 + 1)
    |> Enum.any?(fn y ->
      (x1 - 1)..(x1 + 1) |> Enum.any?(fn x -> x == x2 and y == y2 end)
    end)
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 9)
    content
  end
end
