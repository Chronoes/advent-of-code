defmodule AdventOfCode.Y2021.Day10 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2021/day/10
  """

  @close_open_match %{
    ?) => ?(,
    ?] => ?[,
    ?} => ?{,
    ?> => ?<
  }

  @bracket_points %{
    ?) => 3,
    ?] => 57,
    ?} => 1197,
    ?> => 25137
  }

  @bracket_2nd_points %{
    ?) => 1,
    ?] => 2,
    ?} => 3,
    ?> => 4
  }

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.map(&find_corrupted_line/1)
    |> Enum.map(&elem(&1, 0))
    |> Enum.filter(&Kernel.>(&1, 0))
    |> Enum.sum()
  end

  def find_corrupted_line(chars), do: find_corrupted_line(chars, [])

  defp find_corrupted_line([char | chars], [opening | stack]) do
    case @close_open_match[char] do
      nil ->
        # char is not a closing bracket
        find_corrupted_line(chars, [char, opening | stack])

      ^opening ->
        # char matches opening bracket in stack
        find_corrupted_line(chars, stack)

      _matching ->
        # Invalid closing bracket
        {@bracket_points[char], [opening | stack]}
    end
  end

  defp find_corrupted_line([char | chars], []), do: find_corrupted_line(chars, [char])
  defp find_corrupted_line([], stack), do: {0, stack}

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    open_close_match = Map.new(@close_open_match, fn {key, val} -> {val, key} end)

    results =
      prep_input(input)
      |> Enum.map(&find_corrupted_line/1)
      |> Enum.filter(fn {points, _stack} -> points === 0 end)
      |> Enum.map(fn {_points, stack} -> complete_lines(stack, open_close_match) end)
      |> Enum.sort()

    Enum.at(results, trunc(length(results) / 2))
  end

  def complete_lines(stack, open_close_match) do
    {_completion_list, result} =
      Enum.map_reduce(stack, 0, fn open, acc ->
        closing = open_close_match[open]
        {closing, acc * 5 + @bracket_2nd_points[closing]}
      end)

    result
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 10)
    content
  end
end
