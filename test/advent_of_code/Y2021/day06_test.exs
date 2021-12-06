defmodule AdventOfCode.Y2021.Day06Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2021.Day06, as: Solver

  @sample_input """
  3,4,3,1,2
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 5934
  end

  test "first stage" do
    assert Solver.solve_first() === 365_862
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 26_984_457_539
  end

  test "second stage" do
    assert Solver.solve_second() === 1_653_250_886_439
  end
end
