defmodule AdventOfCode.Y2022.Day01Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2022.Day01, as: Solver

  @sample_input """
  1000
  2000
  3000

  4000

  5000
  6000

  7000
  8000
  9000

  10000
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 24000
  end

  test "first stage" do
    assert Solver.solve_first() === 71506
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 45000
  end

  test "second stage" do
    assert Solver.solve_second() === 209_603
  end
end
