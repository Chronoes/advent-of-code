defmodule AdventOfCode.Y2021.Day07Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2021.Day07, as: Solver

  @sample_input """
  16,1,2,0,4,2,7,1,2,14
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 37
  end

  test "first stage" do
    assert Solver.solve_first() === 344_735
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 168
  end

  test "second stage" do
    assert Solver.solve_second() === 96_798_233
  end
end
