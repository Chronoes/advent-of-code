defmodule AdventOfCode.Y2023.Day09 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2023/day/9
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line) |> Enum.map(&String.to_integer/1) end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.map(fn history ->
      Enum.at(history, -1) +
        (process_history(history)
         |> Enum.sum())
    end)
    |> Enum.sum()
  end

  def process_history(history) do
    process_history(history, [])
  end

  def process_history(history, last_diffs) do
    res =
      Enum.zip(history, tl(history))
      |> Enum.map(fn {a, b} -> b - a end)

    last_diffs = [Enum.at(res, -1) | last_diffs]

    if Enum.sum(res) === 0 do
      last_diffs
    else
      process_history(res, last_diffs)
    end
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> Enum.map(fn history ->
      process_history2(history)
      |> Enum.reduce(fn b, a ->
        b - a
      end)
    end)
    |> Enum.sum()
  end

  def process_history2(history) do
    process_history2(history, [])
  end

  def process_history2(history, last_diffs) do
    res =
      Enum.zip(history, tl(history))
      |> Enum.map(fn {a, b} -> b - a end)

    last_diffs = [hd(history) | last_diffs]

    if Enum.sum(res) === 0 do
      last_diffs
    else
      process_history2(res, last_diffs)
    end
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2023, 9)
    content
  end
end
