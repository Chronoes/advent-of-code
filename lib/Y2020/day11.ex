defmodule AdventOfCode.Y2020.Day11 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/11
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> get_final_arrangement()
    |> Enum.map(fn {row, _} -> count_occupied_seats(row) end)
    |> Enum.sum()
  end

  def get_final_arrangement(seating) do
    Enum.map(seating, &Enum.with_index/1)
    |> Enum.with_index()
    |> arrange_seatings([])
  end

  defp arrange_seatings(seating, prev_seating) do
    if seating === prev_seating do
      seating
    else
      seating
      |> Enum.map(fn {row, row_idx} ->
        {Enum.map(row, &determine_seat_state(&1, row_idx, seating)), row_idx}
      end)
      # |> print_seating()
      |> arrange_seatings(seating)
    end
  end

  defp determine_seat_state({".", _idx} = seat, _row_idx, _seating), do: seat

  defp determine_seat_state({"L", idx} = seat, row_idx, seating) do
    if get_adjacent_seats(row_idx, idx, seating) |> count_occupied_seats() === 0 do
      {"#", idx}
    else
      seat
    end
  end

  defp determine_seat_state({"#", idx} = seat, row_idx, seating) do
    if get_adjacent_seats(row_idx, idx, seating) |> count_occupied_seats() >= 4 do
      {"L", idx}
    else
      seat
    end
  end

  defp count_occupied_seats(seats) do
    Enum.count(seats, fn {s, _idx} -> s === "#" end)
  end

  defp get_adjacent_seats(row_idx, seat_idx, seating) do
    [
      if row_idx - 1 >= 0 do
        Enum.at(seating, row_idx - 1)
        |> elem(0)
        |> seats_on_row(seat_idx)
      else
        []
      end,
      Enum.at(seating, row_idx)
      |> elem(0)
      |> seats_on_row(seat_idx)
      |> Enum.reject(fn {_seat, idx} -> idx === seat_idx end),
      Enum.at(seating, row_idx + 1, {[]}) |> elem(0) |> seats_on_row(seat_idx)
    ]
    |> Enum.concat()
  end

  defp seats_on_row(row, 0), do: Enum.take(row, 2)
  defp seats_on_row(row, seat_idx) when seat_idx === length(row) - 1, do: Enum.slice(row, -2, 2)
  defp seats_on_row(row, seat_idx), do: Enum.slice(row, seat_idx - 1, 3)

  def print_seating(seating) do
    IO.puts("")

    seating
    |> Enum.map(fn {row, _idx} -> Enum.map(row, &elem(&1, 0)) |> Enum.join("") end)
    |> Enum.join("\n")
    |> IO.puts()

    seating
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2020, 11)
    content
  end
end
