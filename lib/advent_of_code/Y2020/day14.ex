defmodule AdventOfCode.Y2020.Day14 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/14
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn
      "mask = " <> mask ->
        {:mask, String.to_charlist(mask)}

      memset ->
        [_, address, value] = Regex.run(~r/mem\[([0-9]+)\] = ([0-9]+)/, memset)
        {:memset, String.to_integer(address), String.to_integer(value)}
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    [{:mask, mask} | tail] = prep_input(input)
    memory = run_memset_value_ops(%{}, tail, mask)
    memory |> Map.values() |> Enum.sum()
  end

  def run_memset_value_ops(memory, [{:memset, address, value} | tail], mask) do
    Map.put(memory, address, apply_value_bitmask(mask, value))
    |> run_memset_value_ops(tail, mask)
  end

  def run_memset_value_ops(memory, [{:mask, mask} | tail], _mask) do
    run_memset_value_ops(memory, tail, mask)
  end

  def run_memset_value_ops(memory, [], _mask), do: memory

  defp apply_bitmask(mask, value, transform_fn) do
    digits =
      value
      |> Integer.digits(2)

    (List.duplicate(0, length(mask) - length(digits)) ++ digits)
    |> Enum.zip(mask)
    |> Enum.map(transform_fn)
  end

  defp apply_value_bitmask(mask, value) do
    apply_bitmask(mask, value, fn
      {_, ?0} -> 0
      {_, ?1} -> 1
      {n, ?X} -> n
    end)
    |> Integer.undigits(2)
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    [{:mask, mask} | tail] = prep_input(input)
    memory = run_memset_address_ops(%{}, tail, mask)
    memory |> Map.values() |> Enum.sum()
  end

  def run_memset_address_ops(memory, [{:memset, address, value} | tail], mask) do
    address = apply_address_bitmask(mask, address)

    Map.put(memory, address, value)
    |> run_memset_address_ops(tail, mask)
  end

  def run_memset_address_ops(memory, [{:mask, mask} | tail], _mask) do
    run_memset_address_ops(memory, tail, mask)
  end

  def run_memset_address_ops(memory, [], _mask), do: memory

  defp apply_address_bitmask(mask, address) do
    apply_bitmask(mask, address, fn
      {n, ?0} -> n
      {_, ?1} -> 1
      {_, ?X} -> ?X
    end)
  end

  def replace_floating_bits([?X | tail]) do
    remaining = replace_floating_bits(tail)
    # TODO: Fix this
    [0, 1 | remaining]
  end

  def replace_floating_bits([n | tail]) do
    [n | replace_floating_bits(tail)]
  end

  def replace_floating_bits([]), do: []

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2020, 14)
    content
  end
end
