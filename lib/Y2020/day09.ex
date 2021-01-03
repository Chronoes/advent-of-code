defmodule AdventOfCode.Y2020.Day09 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/9
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  @impl true
  @spec solve_first(any) :: any
  @spec solve_first(binary, integer) :: any
  def solve_first(input, preamble_count \\ 25) do
    {preamble, nrs} =
      prep_input(input)
      |> Enum.split(preamble_count)

    find_nonmatching_number(preamble, nrs)
  end

  def find_nonmatching_number(preamble, [head | tail]) do
    if contains_sum_of_pairs?(preamble, head) do
      [_ | preamble] = preamble
      find_nonmatching_number(preamble ++ [head], tail)
    else
      head
    end
  end

  def contains_sum_of_pairs?([head | tail], target_sum) do
    Enum.member?(tail, target_sum - head) or contains_sum_of_pairs?(tail, target_sum)
  end

  def contains_sum_of_pairs?([], _head), do: false

  @impl true
  @spec solve_second(any) :: any
  @spec solve_second(any, integer) :: any
  def solve_second(input, preamble_count \\ 25) do
    nr_list = prep_input(input)

    {preamble, nrs} = nr_list |> Enum.split(preamble_count)

    no_match_nr = find_nonmatching_number(preamble, nrs)

    found_nrs = get_contiguous_nrs(nr_list, no_match_nr)
    Enum.min(found_nrs) + Enum.max(found_nrs)
  end

  def get_contiguous_nrs([head | tail], target_sum) do
    {sum, nrs} =
      Enum.reduce_while(tail, {head, [head]}, fn nr, {acc, nrs} ->
        nrs = [nr | nrs]
        acc = acc + nr

        if acc < target_sum do
          {:cont, {acc, nrs}}
        else
          {:halt, {acc, nrs}}
        end
      end)

    if sum === target_sum and length(nrs) > 1 do
      nrs
    else
      get_contiguous_nrs(tail, target_sum)
    end
  end

  def get_contiguous_nrs([], _target_sum), do: []

  @impl true
  def read_input do
    File.read!("priv/inputs/Y2020/day09.txt")
  end
end
