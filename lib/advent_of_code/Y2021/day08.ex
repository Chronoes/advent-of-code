defmodule AdventOfCode.Y2021.Day08 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2021/day/8
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, " | ")
      |> Enum.map(&String.split/1)
      |> Enum.map(fn list -> Enum.map(list, &String.to_charlist/1) end)
      |> List.to_tuple()
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.map(fn {_signals, output} ->
      Enum.count(output, fn digit ->
        length(digit) in [2, 3, 4, 7]
      end)
    end)
    |> Enum.sum()
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> Enum.map(&decode_digit_output/1)
    |> Enum.sum()
  end

  def decode_digit_output({signals, output}) do
    decoded_signals = decode_signals(signals)

    output
    |> Enum.map(&Enum.sort/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.map(&Map.get(decoded_signals, &1))
    |> Enum.join()
    |> String.to_integer()
  end

  def decode_signals(signals) do
    processed =
      signals
      |> Enum.map(&MapSet.new/1)
      |> Enum.sort(fn s1, s2 -> MapSet.size(s1) <= MapSet.size(s2) end)

    {[d1, d7, d4, d8], processed} =
      Enum.split_with(processed, fn signal -> MapSet.size(signal) in [2, 3, 4, 7] end)

    {[d3, d0], processed} =
      Enum.split_with(processed, fn signal ->
        MapSet.size(signal) in [5, 6] and MapSet.subset?(d7, signal) and
          !MapSet.subset?(d4, signal)
      end)

    {[d9], processed} =
      Enum.split_with(processed, fn signal ->
        MapSet.size(signal) === 6 and MapSet.subset?(d4, signal)
      end)

    {[d5], processed} =
      Enum.split_with(processed, fn signal ->
        MapSet.size(signal) === 5 and MapSet.subset?(signal, d9) and !MapSet.subset?(d1, signal)
      end)

    {[d6], [d2]} =
      Enum.split_with(processed, fn signal ->
        MapSet.size(signal) === 6 and MapSet.subset?(d5, signal) and !MapSet.subset?(d1, signal)
      end)

    %{
      d0 => 0,
      d1 => 1,
      d2 => 2,
      d3 => 3,
      d4 => 4,
      d5 => 5,
      d6 => 6,
      d7 => 7,
      d8 => 8,
      d9 => 9
    }
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 8)
    content
  end
end
