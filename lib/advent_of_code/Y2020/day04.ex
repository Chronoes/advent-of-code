defmodule AdventOfCode.Y2020.Day04 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/4
  """

  @required_fields ~w(byr iyr eyr hgt hcl ecl pid)

  defp prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(fn p ->
      String.split(p) |> Enum.map(fn f -> String.split(f, ":") |> List.to_tuple() end)
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.count(&has_required_fields?/1)
  end

  @spec has_required_fields?([{binary, binary}, ...]) :: boolean
  def has_required_fields?(fields) do
    field_names = Enum.map(fields, &elem(&1, 0)) |> MapSet.new()
    MapSet.subset?(MapSet.new(@required_fields), field_names)
  end

  @spec has_valid_values?([{binary, binary}, ...]) :: boolean
  def has_valid_values?(fields) do
    Enum.all?(fields, &validate_field/1)
  end

  defp validate_field({"byr", value}), do: "1920" <= value and value <= "2002"
  defp validate_field({"iyr", value}), do: "2010" <= value and value <= "2020"
  defp validate_field({"eyr", value}), do: "2020" <= value and value <= "2030"

  defp validate_field({"hgt", value}) do
    case Regex.run(~r/^([0-9]{2,3})(cm|in)$/, value) do
      [_, nr, "cm"] ->
        "150" <= nr and nr <= "193"

      [_, nr, "in"] ->
        "59" <= nr and nr <= "76"

      _ ->
        false
    end
  end

  defp validate_field({"hcl", value}), do: String.match?(value, ~r/^#[a-f0-9]{6}$/i)
  defp validate_field({"ecl", value}), do: Enum.member?(~w(amb blu brn gry grn hzl oth), value)
  defp validate_field({"pid", value}), do: String.match?(value, ~r/^[0-9]{9}$/)
  defp validate_field(_), do: true

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> Enum.filter(&has_required_fields?/1)
    |> Enum.count(&has_valid_values?/1)
  end

  @impl true
  def read_input do
    File.read!("priv/inputs/Y2020/day04.txt")
  end
end
