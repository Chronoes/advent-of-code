defmodule AdventOfCode.Y2021.Day11 do
  use AdventOfCode.Day

  alias AdventOfCode.TwoDeeList

  @moduledoc """
  https://adventofcode.com/2021/day/11
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.split(line, "")
      |> Enum.filter(fn nr -> nr !== "" end)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> TwoDeeList.add_coords()
    |> simulate_turns()
    |> elem(1)
  end

  def simulate_turns(octopi, turns \\ 100, total_flashes \\ 0)

  def simulate_turns(octopi, 0, total_flashes), do: {octopi, total_flashes}

  def simulate_turns(octopi, turns, total_flashes) do
    {octopi, new_flashes} =
      octopi
      |> Enum.map(&Enum.map(&1, fn {energy, coords} -> {energy + 1, coords} end))
      |> process_flashes()

    # octopi
    # |> Enum.map_join(
    #   "\n",
    #   &Enum.map_join(&1, fn {a, _b} -> a end)
    # )
    # |> IO.puts()

    # IO.puts("")

    octopi
    |> simulate_turns(turns - 1, total_flashes + new_flashes)
  end

  def process_flashes(octopi, flash_count \\ 0) do
    flashes =
      Enum.flat_map(octopi, fn row ->
        Enum.filter(row, fn {energy, _coords} -> energy > 9 end)
      end)

    octopi =
      TwoDeeList.map(octopi, fn
        {energy, coords} when energy > 9 -> {0, coords}
        octopus -> octopus
      end)

    case flashes do
      [] ->
        {octopi, flash_count}

      flashes ->
        flashes
        |> Enum.flat_map(fn {_energy, coords} -> TwoDeeList.find_adjacent(coords, octopi) end)
        |> Enum.dedup()
        |> Enum.reduce(octopi, fn {_energy, {x, y}}, acc ->
          List.update_at(acc, y, fn row ->
            List.update_at(row, x, fn
              {0, _} -> {0, {x, y}}
              {energy, _} -> {energy + 1, {x, y}}
            end)
          end)
        end)
        |> process_flashes(flash_count + length(flashes))
    end
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 11)
    content
  end
end
