defmodule AdventOfCode.Y2023.Day05 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2023/day/5
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    [seeds | rest] =
      input
      |> String.trim()
      |> String.split("\n\n")

    seeds =
      String.replace(seeds, "seeds: ", "") |> String.split(" ") |> Enum.map(&String.to_integer/1)

    seed_maps =
      rest
      |> Enum.reduce([], fn line, acc ->
        [_header | data] = String.split(line, "\n")
        # header = String.replace(header, " map:", "")

        data =
          Enum.map(data, fn row -> String.split(row, " ") |> Enum.map(&String.to_integer/1) end)

        [data | acc]
      end)
      |> Enum.reverse()

    {seeds, seed_maps}
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    {seeds, seed_maps} = prep_input(input)

    seeds
    |> Enum.map(fn seed ->
      Enum.reduce(seed_maps, seed, fn map, final_nr ->
        case Enum.find(map, fn [_dst, src, range] ->
               final_nr >= src and final_nr < src + range
             end) do
          nil -> final_nr
          [dst, src, _range] -> final_nr - src + dst
        end
      end)
    end)
    |> Enum.min()
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    {seeds, seed_maps} = prep_input(input)

    # not finished
    seeds
    |> Enum.chunk_every(2)
    |> Enum.map(fn [seed, seed_range] ->
      Enum.reduce(seed_maps, seed, fn map, final_nr ->
        case Enum.find(map, fn [_dst, src, range] ->
               final_nr >= src and final_nr < src + range
             end) do
          nil -> final_nr
          [dst, src, _range] -> final_nr - src + dst
        end
      end)
    end)
    |> Enum.min()
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2023, 5)
    content
  end
end
