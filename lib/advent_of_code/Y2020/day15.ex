defmodule AdventOfCode.Y2020.Day15 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/15
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_atom/1)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    starting_nrs = prep_input(input)

    starting_nrs
    |> Enum.with_index(1)
    |> Enum.reverse()
    |> Enum.map(fn {nr, turn} -> {nr, {nil, turn}} end)
    |> Keyword.new()
    |> simulate_turns(length(starting_nrs) + 1)
    |> to_string()
  end

  def simulate_turns(nrs_spoken, turn, max_turns \\ 2020)

  def simulate_turns([{nr, _turns} | _nrs_spoken], turn, max_turns) when turn > max_turns,
    do: nr

  def simulate_turns(nrs_spoken, turn, max_turns) do
    {_last_nr, {snd, fst}} = hd(nrs_spoken)

    new_key = if is_nil(snd), do: :"0", else: :"#{snd - fst}"

    value =
      case Keyword.get(nrs_spoken, new_key) do
        nil -> {nil, turn}
        {nil, f} -> {turn, f}
        {s, _f} -> {turn, s}
      end

    nrs_spoken
    |> Keyword.put(new_key, value)
    |> simulate_turns(turn + 1, max_turns)
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    starting_nrs = prep_input(input)

    starting_nrs
    |> Enum.with_index(1)
    |> Enum.reverse()
    |> Enum.map(fn {nr, turn} -> {nr, {nil, turn}} end)
    |> Keyword.new()
    |> simulate_turns(length(starting_nrs) + 1, 30_000_000)
    |> to_string()
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2020, 15)
    content
  end
end
