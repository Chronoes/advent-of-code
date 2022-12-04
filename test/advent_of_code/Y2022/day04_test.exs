defmodule AdventOfCode.Y2022.Day04Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2022.Day04, as: Solver

  @sample_input """
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 2
  end

  test "first stage" do
    assert Solver.solve_first() === 573
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 4
  end

  test "second stage" do
    assert Solver.solve_second() === 867
  end
end
