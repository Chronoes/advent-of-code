defmodule AdventOfCode.Y2023.Day03 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2023/day/3
  """
  alias AdventOfCode.TwoDeeList

  def make_nr_entry(nr) do
    nr = Enum.reverse(nr)
    {x_first, _y} = List.first(nr) |> elem(1)
    {x_last, y} = List.last(nr) |> elem(1)

    nr = Enum.map(nr, fn {d, _} -> d - ?0 end) |> Integer.undigits()

    {nr, {x_first..x_last, y}}
  end

  @spec prep_input(any) :: any
  def prep_input(input) do
    list =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn line ->
        String.to_charlist(line)
      end)
      |> TwoDeeList.add_coords()

    nrs =
      list
      |> Enum.reduce([], fn row, nrs ->
        {nrs, active} =
          Enum.reduce(row, {nrs, []}, fn {col, coords}, {nrs, active} ->
            case active do
              nr when col in ?0..?9 ->
                {nrs, [{col, coords} | nr]}

              nr when nr != [] ->
                {[make_nr_entry(nr) | nrs], []}

              _nr ->
                {nrs, []}
            end
          end)

        if active != [] do
          [make_nr_entry(active) | nrs]
        else
          nrs
        end
      end)
      |> Enum.reverse()

    # IO.inspect(nrs)

    {list, nrs}
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    {list, nrs} = prep_input(input)

    list
    |> Enum.flat_map(fn row ->
      Enum.map(row, fn
        {el, coords} when el != ?. and el not in ?0..?9 ->
          {x_range, y_range} = TwoDeeList.get_adjacent_coords(coords, list)

          Enum.reject(nrs, fn {_nr, {x_r, y}} ->
            y not in y_range or Range.disjoint?(x_r, x_range)
          end)
          |> Enum.map(&elem(&1, 0))
          |> Enum.sum()

        _ ->
          nil
      end)
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.sum()
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    {list, nrs} = prep_input(input)

    list
    |> Enum.flat_map(fn row ->
      Enum.map(row, fn
        {el, coords} when el == ?* ->
          {x_range, y_range} = TwoDeeList.get_adjacent_coords(coords, list)

          adjacent_nrs =
            Enum.reject(nrs, fn {_nr, {x_r, y}} ->
              y not in y_range or Range.disjoint?(x_r, x_range)
            end)
            |> Enum.map(&elem(&1, 0))

          if length(adjacent_nrs) == 2 do
            Enum.product(adjacent_nrs)
          else
            nil
          end

        _ ->
          nil
      end)
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.sum()
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2023, 3)
    content
  end
end
