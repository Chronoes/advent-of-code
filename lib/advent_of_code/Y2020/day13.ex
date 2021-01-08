defmodule AdventOfCode.Y2020.Day13 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/13
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    [timestamp, ids] =
      input
      |> String.trim()
      |> String.split("\n")

    {String.to_integer(timestamp), String.split(ids, ",")}
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    {timestamp, ids} = prep_input(input)

    {id, minutes} =
      ids
      |> Enum.filter(fn id -> id !== "x" end)
      |> Enum.map(&String.to_integer/1)
      |> Enum.map(fn id -> {id, id - rem(timestamp, id)} end)
      |> Enum.min_by(&elem(&1, 1))

    id * minutes
  end

  @impl true
  @spec solve_second(any) :: any
  @spec solve_second(any, keyword) :: any
  def solve_second(input, opts \\ []) do
    {_timestamp, ids} = prep_input(input)

    indexed =
      ids
      |> Enum.with_index()
      |> Enum.filter(&(elem(&1, 0) !== "x"))
      |> Enum.map(fn {nr, idx} ->
        nr = String.to_integer(nr)

        {nr, rem(idx, nr)}
      end)

    {highest, remainder} = Enum.max_by(indexed, &elem(&1, 0))

    {seed, _opts} = Keyword.pop_first(opts, :seed, 100_000_000_000_000)
    earliest_remainder_match(indexed, highest, seed + highest - rem(seed, highest) - remainder)
  end

  defp earliest_remainder_match(nrs, step, match) do
    if Enum.all?(nrs, fn {nr, remainder} -> rem(match + remainder, nr) === 0 end) do
      match
    else
      earliest_remainder_match(nrs, step, match + step)
    end
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2020, 13)
    content
  end
end
