defmodule AdventOfCode.Y2021.Day05 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2021/day/5
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, " -> ") |> Enum.map(&create_line_points/1) |> List.to_tuple()
    end)
  end

  def create_line_points(line) do
    String.split(line, ",") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.reject(&is_nil(line_parallel_to(&1)))
    |> map_intersected_lines()
    |> find_intersection_count()
  end

  def create_line_map(lines) do
    {x, y} =
      Enum.reduce(lines, {0, 0}, fn {{x1, y1}, {x2, y2}}, {x, y} ->
        {Enum.max([x1, x2, x]), Enum.max([y1, y2, y])}
      end)

    Enum.map(0..y, fn _ -> Enum.map(0..x, fn _ -> 0 end) end)
  end

  def map_intersected_lines(lines), do: map_intersected_lines(lines, create_line_map(lines))

  def map_intersected_lines([], line_map), do: line_map

  def map_intersected_lines([line | lines], line_map) do
    {{x1, y1}, {x2, y2}} = line

    line_map =
      case line_parallel_to(line) do
        :x ->
          line_map
          |> List.update_at(y1, fn row ->
            row
            |> Stream.with_index()
            |> Enum.map(fn {col, x} ->
              if x in x1..x2,
                do: col + 1,
                else: col
            end)
          end)

        :y ->
          line_map
          |> Stream.with_index()
          |> Enum.map(fn {row, y} ->
            if y in y1..y2,
              do: row |> List.update_at(x1, fn col -> col + 1 end),
              else: row
          end)

        nil ->
          get_x_pos =
            if (x1 < x2 and y1 < y2) or (x1 > x2 and y1 > y2) do
              fn y -> y - y1 + x1 end
            else
              fn y -> y1 - y + x1 end
            end

          line_map
          |> Stream.with_index()
          |> Enum.map(fn {row, y} ->
            if y in y1..y2,
              do: List.update_at(row, get_x_pos.(y), fn col -> col + 1 end),
              else: row
          end)
      end

    map_intersected_lines(lines, line_map)
  end

  def find_intersection_count(line_map) do
    line_map |> Enum.map(fn row -> Enum.count(row, fn col -> col > 1 end) end) |> Enum.sum()
  end

  def line_parallel_to({{x1, _y1}, {x2, _y2}}) when x1 == x2, do: :y
  def line_parallel_to({{_x1, y1}, {_x2, y2}}) when y1 == y2, do: :x
  def line_parallel_to(_line), do: nil

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> map_intersected_lines()
    |> find_intersection_count()
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 5)
    content
  end
end
