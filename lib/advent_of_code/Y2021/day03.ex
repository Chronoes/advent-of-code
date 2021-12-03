defmodule AdventOfCode.Y2021.Day03 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2021/day/3
  """

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
    numbers = prep_input(input)

    {gamma_rate, epsilon_rate} =
      numbers |> find_one_bit_counts() |> get_gamma_and_epsilon_rate(length(numbers))

    List.to_integer(gamma_rate, 2) * List.to_integer(epsilon_rate, 2)
  end

  def find_one_bit_counts([x | nrs]) do
    bits = 1..length(x) |> Enum.map(fn _ -> 0 end)
    Enum.reduce([x | nrs], bits, &calc_one_bit_counts/2)
  end

  defp calc_one_bit_counts(x, bits) do
    Enum.zip(x, bits)
    |> Enum.map(fn {c, ones} ->
      case c do
        ?1 -> ones + 1
        ?0 -> ones
      end
    end)
  end

  def get_gamma_and_epsilon_rate(one_bits, input_count) do
    gamma_rate =
      Enum.map(one_bits, fn ones ->
        if ones > input_count / 2 do
          ?1
        else
          ?0
        end
      end)

    epsilon_rate =
      Enum.map(gamma_rate, fn c ->
        case c do
          ?0 -> ?1
          ?1 -> ?0
        end
      end)

    {gamma_rate, epsilon_rate}
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    numbers = prep_input(input)

    one_bits = find_one_bit_counts(numbers)
    Enum.filter(numbers, fn nr -> nr end)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 3)
    content
  end
end
