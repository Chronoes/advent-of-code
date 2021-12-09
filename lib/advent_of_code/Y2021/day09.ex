defmodule AdventOfCode.Y2021.Day09 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2021/day/9
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, "")
      |> Enum.filter(fn nr -> nr !== "" end)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> find_lowest_points()
    |> Enum.map(fn {height, _coords} ->
      height + 1
    end)
    |> Enum.sum()
  end

  def find_lowest_points(heightmap) do
    heightmap
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {height, x} -> {height, {x, y}} end)
      |> Enum.filter(fn {height, coords} ->
        find_adjacent(coords, heightmap)
        |> is_lowest_point?(height)
      end)
    end)
  end

  def find_adjacent({x, y}, heightmap) do
    min_x = max(x - 1, 0)
    max_x = min(x + 1, length(hd(heightmap)) - 1)

    min_y = max(y - 1, 0)
    max_y = min(y + 1, length(heightmap) - 1)

    min_y..max_y
    |> Enum.flat_map(fn q ->
      row = Enum.at(heightmap, q)

      min_x..max_x
      |> Enum.reject(fn p -> p == x and q == y end)
      |> Enum.map(fn p -> {Enum.at(row, p), {p, q}} end)
    end)
  end

  def is_lowest_point?(adjacents, height) do
    Enum.all?(adjacents, fn {adjacent, _coords} -> height < adjacent end)
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    heightmap = prep_input(input)

    heightmap
    |> find_lowest_points()
    |> Enum.map(&find_basins(&1, heightmap))
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(&length/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def find_basins({8, _coords} = point, _heightmap), do: [point]

  def find_basins({height, coords}, heightmap) do
    basin =
      find_adjacent(coords, heightmap)
      |> Enum.filter(fn {adj, _adj_coords} -> adj < 9 and adj - height === 1 end)
      |> Enum.flat_map(fn adj_point ->
        find_basins(adj_point, heightmap)
      end)

    [{height, coords} | basin]
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 9)
    content
  end
end
