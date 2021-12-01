defmodule AdventOfCode.Y2020.Day14Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day14, as: Solver

  @sample_input """
  mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
  mem[8] = 11
  mem[7] = 101
  mem[8] = 0
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 165
  end

  test "first stage" do
    assert Solver.solve_first() === 7_440_382_076_205
  end

  @tag :skip
  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 208
  end

  @tag :skip
  test "second stage" do
    assert Solver.solve_second() === true
  end
end
