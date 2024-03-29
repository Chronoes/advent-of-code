defmodule AdventOfCode.Y2023.Day05Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2023.Day05, as: Solver

  @sample_input """
  seeds: 79 14 55 13

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
  39 0 15

  fertilizer-to-water map:
  49 53 8
  0 11 42
  42 0 7
  57 7 4

  water-to-light map:
  88 18 7
  18 25 70

  light-to-temperature map:
  45 77 23
  81 45 19
  68 64 13

  temperature-to-humidity map:
  0 69 1
  1 0 69

  humidity-to-location map:
  60 56 37
  56 93 4
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 35
  end

  test "first stage" do
    assert Solver.solve_first() === 214_922_730
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 46
  end

  # Keeping skip because it uses bruteforce and takes at least 9min to run on Ryzen 7 5800X
  @tag :skip
  test "second stage" do
    assert Solver.solve_second() === 148_041_808
  end
end
