defmodule AdventOfCode.TwoDeeList do
  @type point :: {number, number}
  @type list_elem :: {any, point()}
  @type t :: [[list_elem()]]

  @spec add_coords([[any]]) :: t()
  def add_coords(list) do
    Enum.with_index(list, fn row, y ->
      Enum.with_index(row, fn el, x -> {el, {x, y}} end)
    end)
  end

  @spec find_adjacent(point :: point(), list :: t()) :: [list_elem()]
  def find_adjacent({x, y}, list) do
    min_x = max(x - 1, 0)
    max_x = min(x + 1, length(hd(list)) - 1)

    min_y = max(y - 1, 0)
    max_y = min(y + 1, length(list) - 1)

    min_y..max_y
    |> Enum.flat_map(fn q ->
      row = Enum.at(list, q)

      min_x..max_x
      |> Enum.reject(fn p -> p == x and q == y end)
      |> Enum.map(fn p -> Enum.at(row, p) end)
    end)
  end

  @spec find_directly_adjacent(point :: point(), list :: t()) :: [list_elem()]
  def find_directly_adjacent({x, y}, list) do
    find_adjacent({x, y}, list)
    |> Enum.reject(fn {_, {p, q}} -> p !== x and (y - 1 === q || y + 1 === q) end)
  end

  @spec map([[any]], (any -> any)) :: [[any]]
  def map(list, fun) do
    Enum.map(list, fn row -> Enum.map(row, &fun.(&1)) end)
  end
end
