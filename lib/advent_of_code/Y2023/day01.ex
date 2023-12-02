defmodule AdventOfCode.Y2023.Day01 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2023/day/1
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.map(fn line ->
      String.to_charlist(line)
      |> Enum.filter(&(&1 in ?0..?9))
      |> Enum.map(&map_char_to_digit/1)
      |> sum_first_last_char()
    end)
    |> Enum.sum()
  end

  defp map_char_to_digit(char) do
    char - ?0
  end

  defp sum_first_last_char(digits) do
    [first | rest] = digits

    last = List.last(rest, first)
    first * 10 + last
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> Enum.map(fn line ->
      String.to_charlist(line)
      |> process_lines()
      |> Enum.reject(&is_nil/1)
      |> Enum.reverse()
      |> sum_first_last_char()
    end)
    |> Enum.sum()
  end

  defp process_lines(chars) do
    process_lines(chars, [])
  end

  defp process_lines([], digits), do: digits

  defp process_lines(chars, digits) do
    [char | tail] = chars

    if char in ?0..?9 do
      process_lines(tail, [map_char_to_digit(char) | digits])
    else
      process_lines(tail, [match_numeric_word_to_digit(chars) | digits])
    end
  end

  defp match_numeric_word_to_digit(chars) do
    [
      {~c"zero", 0},
      {~c"one", 1},
      {~c"two", 2},
      {~c"three", 3},
      {~c"four", 4},
      {~c"five", 5},
      {~c"six", 6},
      {~c"seven", 7},
      {~c"eight", 8},
      {~c"nine", 9}
    ]
    |> Enum.find({nil, nil}, fn
      {word, _digit} -> Enum.take(chars, length(word)) == word
    end)
    |> elem(1)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2023, 1)
    content
  end
end
