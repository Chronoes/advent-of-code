defmodule AdventOfCode.Y2021.Day02 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2021/day/2
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn input ->
      [act, amount] = String.split(input)
      {act, String.to_integer(amount)}
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    {pos, depth} =
      prep_input(input)
      |> Enum.reduce({0, 0}, &process_instruction/2)

    pos * depth
  end

  def process_instruction({"forward", amount}, {pos, depth}), do: {pos + amount, depth}
  def process_instruction({"up", amount}, {pos, depth}), do: {pos, depth - amount}
  def process_instruction({"down", amount}, {pos, depth}), do: {pos, depth + amount}

  def process_instruction({"forward", amount}, {pos, depth, aim}),
    do: {pos + amount, depth + aim * amount, aim}

  def process_instruction({"up", amount}, {pos, depth, aim}), do: {pos, depth, aim - amount}
  def process_instruction({"down", amount}, {pos, depth, aim}), do: {pos, depth, aim + amount}

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    {pos, depth, _aim} =
      prep_input(input)
      |> Enum.reduce({0, 0, 0}, &process_instruction/2)

    pos * depth
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 2)
    content
  end
end
