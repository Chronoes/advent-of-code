defmodule AdventOfCode.Y2020.Day02 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/2
  """

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.count(&is_password_correct_first?/1)
  end

  defp parse_password(line) do
    [range, policy, password] = String.split(line, " ")
    [start_r, end_r] = String.split(range, "-") |> Enum.map(&String.to_integer/1)
    policy = String.trim(policy, ":")
    {{start_r, end_r}, policy, password}
  end

  def is_password_correct_first?(line) do
    {{start_r, end_r}, policy, password} = parse_password(line)
    char_count = String.split(password, "") |> Enum.count(fn c -> c == policy end)
    start_r <= char_count and char_count <= end_r
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.count(&is_password_correct_second?/1)
  end

  def is_password_correct_second?(line) do
    {{pos1, pos2}, policy, password} = parse_password(line)
    at_pos1? = String.at(password, pos1 - 1) == policy
    at_pos2? = String.at(password, pos2 - 1) == policy

    (at_pos1? and not at_pos2?) or (not at_pos1? and at_pos2?)
  end

  @impl true
  def read_input do
    File.read!("priv/inputs/Y2020/day02.txt")
  end
end
