defmodule AdventOfCode.Y2020.Day01 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/1
  """

  defp prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    {first, second} =
      prep_input(input)
      |> find_pair()

    first * second
  end

  @spec find_pair([integer, ...]) :: {integer, nil | integer}
  def find_pair([head | tail]) do
    {first, second} = find_match(head, tail)

    if is_nil(second) do
      find_pair(tail)
    else
      {first, second}
    end
  end

  def find_pair([]), do: raise("List must have at least 2 numbers")

  @spec find_match(integer, [integer, ...]) :: {integer, nil | integer}
  def find_match(first, []), do: {first, nil}

  def find_match(first, [head | _tail]) when first + head == 2020 do
    {first, head}
  end

  def find_match(first, [_head | tail]) do
    find_match(first, tail)
  end

  def find_triplet([head | tail]) do
    result = find_triplet(head, tail)

    if is_nil(result) do
      find_triplet(tail)
    else
      result
    end
  end

  def find_triplet([]), do: raise("List must have at least 3 numbers")

  defp find_triplet(head1, [head2 | tail]) do
    {_first, second} = find_match(head1 + head2, tail)

    if is_nil(second) do
      find_triplet(head1, tail)
    else
      {head1, head2, second}
    end
  end

  defp find_triplet(_head, []), do: nil

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    {first, second, third} =
      prep_input(input)
      |> find_triplet()

    first * second * third
  end

  @impl true
  def read_input do
    File.read!("priv/inputs/Y2020/day01.txt")
  end
end
