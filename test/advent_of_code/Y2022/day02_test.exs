defmodule AdventOfCode.Y2022.Day02Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2022.Day02, as: Solver

  @sample_input """
  A Y
  B X
  C Z
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 15
  end

  test "first stage" do
    assert Solver.solve_first() === 12535
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 12
  end

  test "second stage" do
    assert Solver.solve_second() === 15457
  end
end
