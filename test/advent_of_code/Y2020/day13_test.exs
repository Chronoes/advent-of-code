defmodule AdventOfCode.Y2020.Day13Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day13, as: Solver

  @sample_input """
  939
  7,13,x,x,59,x,31,19
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 295
  end

  test "first stage" do
    assert Solver.solve_first() === 3789
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input, seed: 0) === 1_068_781
  end

  test "second stage other samples" do
    assert Solver.solve_second("0\n17,x,13,19", seed: 0) === 3417
    assert Solver.solve_second("0\n67,7,59,61", seed: 0) === 754_018
    assert Solver.solve_second("0\n67,x,7,59,61", seed: 0) === 779_210
    assert Solver.solve_second("0\n67,7,x,59,61", seed: 0) === 1_261_476
    assert Solver.solve_second("0\n1789,37,47,1889", seed: 0) === 1_202_161_486
  end

  test "second stage custom sample" do
    assert Solver.solve_second("0\n5,7,11,3", seed: 0) === 405
  end

  @tag :skip
  test "second stage" do
    assert Solver.solve_second() === true
  end
end
