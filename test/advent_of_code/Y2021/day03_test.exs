defmodule AdventOfCode.Y2021.Day03Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2021.Day03, as: Solver

  @sample_input """
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 198
  end

  test "first stage" do
    assert Solver.solve_first() === 2_972_336
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 230
  end

  test "second stage" do
    assert Solver.solve_second() === 3_368_358
  end
end
