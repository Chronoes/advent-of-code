defmodule AdventOfCode.Y2020.Day05 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/5
  """

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&calc_seat_id/1)
    |> Enum.max()
  end

  def calc_seat_id(seat_def) do
    {row, column} = calc_row_and_column(seat_def, 0..127)
    row * 8 + column
  end

  defp calc_row_and_column("F" <> seat_def, range),
    do: calc_row_and_column(seat_def, lower_half(range))

  defp calc_row_and_column("B" <> seat_def, range),
    do: calc_row_and_column(seat_def, upper_half(range))

  defp calc_row_and_column(seat_def, first.._last), do: {first, calc_column(seat_def, 0..7)}

  defp calc_column("R" <> seat_def, range), do: calc_column(seat_def, upper_half(range))
  defp calc_column("L" <> seat_def, range), do: calc_column(seat_def, lower_half(range))
  defp calc_column("", first.._last), do: first

  defp lower_half(first..last), do: first..Integer.floor_div(first + last, 2)
  defp upper_half(first..last), do: (Integer.floor_div(first + last, 2) + 1)..last

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&calc_seat_id/1)
    |> Enum.sort()
    |> find_middle_id()
  end

  defp find_middle_id([prev, next | _tail]) when next - prev == 2, do: prev + 1
  defp find_middle_id([_head | tail]), do: find_middle_id(tail)

  @impl true
  def read_input do
    File.read!("priv/inputs/Y2020/day05.txt")
  end
end
