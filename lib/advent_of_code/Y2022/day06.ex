defmodule AdventOfCode.Y2022.Day06 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2022/day/6
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.to_charlist()
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> find_unique_charseq(4)
  end

  def find_unique_charseq(input, seq_len) do
    find_unique_charseq(input, seq_len, 0)
  end

  defp find_unique_charseq(input, seq_len, start) do
    if Enum.slice(input, start..(start + seq_len - 1)) |> unique_chars?() do
      start + seq_len
    else
      find_unique_charseq(input, seq_len, start + 1)
    end
  end

  def unique_chars?(list) do
    uniq_list = Enum.uniq(list)
    length(uniq_list) === length(list)
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> find_unique_charseq(14)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 6)
    content
  end
end
