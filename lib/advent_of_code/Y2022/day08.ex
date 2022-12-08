defmodule AdventOfCode.Y2022.Day08 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2022/day/8
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.graphemes(line) |> Enum.map(fn nr -> Integer.parse(nr) |> elem(0) end)
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    trees =
      prep_input(input)
      |> AdventOfCode.TwoDeeList.add_coords()

    visited = visible_row_trees(trees, MapSet.new())

    visited = visible_row_trees(AdventOfCode.Util.List.transpose(trees), visited)
    MapSet.size(visited)
  end

  def visible_row_trees([], visited), do: visited

  def visible_row_trees([row | trees], visited) do
    visited = map_visited_nodes(row, -1, visited)
    visited = map_visited_nodes(Enum.reverse(row), -1, visited)
    visible_row_trees(trees, visited)
  end

  def map_visited_nodes([], _highest, visited), do: visited

  def map_visited_nodes([{t, coords} | rest], highest, visited) do
    if t > highest do
      map_visited_nodes(rest, t, MapSet.put(visited, coords))
    else
      map_visited_nodes(rest, highest, visited)
    end
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    trees =
      prep_input(input)
      |> AdventOfCode.TwoDeeList.add_coords()

    AdventOfCode.TwoDeeList.map(trees, &calculate_score(&1, trees))
    |> Enum.map(&Enum.max/1)
    |> Enum.max()
  end

  def calculate_score({t, {x, y}}, trees) do
    (get_trees_in_row(trees, {x + 1, y}, 1)
     |> count_trees_lower_than(t)) *
      (get_trees_in_row(trees, {x - 1, y}, -1)
       |> count_trees_lower_than(t)) *
      (get_trees_in_col(trees, {x, y + 1}, 1)
       |> count_trees_lower_than(t)) *
      (get_trees_in_col(trees, {x, y - 1}, -1)
       |> count_trees_lower_than(t))
  end

  def get_trees_in_row(trees, {x, y}, 1), do: Enum.at(trees, y) |> Enum.drop(x)

  def get_trees_in_row(trees, {x, y}, -1),
    do: Enum.at(trees, y) |> Enum.take(x + 1) |> Enum.reverse()

  def get_trees_in_col(trees, {x, y}, _)
      when x == -1 or y == -1 or length(trees) == y or length(hd(trees)) == x,
      do: []

  def get_trees_in_col(trees, {x, y}, y1) do
    value = Enum.at(trees, y) |> Enum.at(x)
    [value | get_trees_in_col(trees, {x, y + y1}, y1)]
  end

  def count_trees_lower_than(trees, t) do
    Enum.reduce_while(trees, 0, fn
      {n, _}, acc when n < t ->
        {:cont, acc + 1}

      _, acc ->
        {:halt, acc + 1}
    end)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 8)
    content
  end
end
