defmodule AdventOfCode.Y2023.Day01Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2023.Day01, as: Solver

  @sample_input """
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
  """

  @sample_input2 """
  two1nine
  eightwothree
  abcone2threexyz
  xtwone3four
  4nineeightseven2
  zoneight234
  7pqrstsixteen
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 142
  end

  test "first stage" do
    assert Solver.solve_first() === 55029
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input2) === 281
  end

  test "second stage" do
    assert Solver.solve_second() === 55686
  end
end
