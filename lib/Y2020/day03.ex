defmodule AdventOfCode.Y2020.Day03 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/3
  """

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> count_trees()
  end

  def count_trees(lines, opts \\ []) do
    count_trees(lines, 0, 0, opts)
  end

  defp count_trees([head | tail], count, curr_pos, opts) do
    curr_pos = rem(curr_pos, String.length(head))

    count =
      if String.at(head, curr_pos) == "#" do
        count + 1
      else
        count
      end

    right = Keyword.get(opts, :right, 3)
    down = Keyword.get(opts, :down, 1)

    tail = Enum.drop(tail, down - 1)

    count_trees(tail, count, curr_pos + right, opts)
  end

  defp count_trees([], count, _curr_pos, _opts), do: count

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    lines =
      input
      |> String.trim()
      |> String.split("\n")

    [
      [right: 1, down: 1],
      [right: 3, down: 1],
      [right: 5, down: 1],
      [right: 7, down: 1],
      [right: 1, down: 2]
    ]
    |> Enum.map(&count_trees(lines, &1))
    |> Enum.reduce(&*/2)
  end

  @impl true
  def read_input do
    File.read!("priv/inputs/Y2020/day03.txt")
  end
end
