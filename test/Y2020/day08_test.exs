defmodule AdventOfCode.Y2020.Day08Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day08, as: Solver

  @sample_input """
  nop +0
  acc +1
  jmp +4
  acc +3
  jmp -3
  acc -99
  acc +1
  jmp -4
  acc +6
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) == 5
  end

  test "first stage" do
    assert Solver.solve_first() == 1816
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) == 8
  end

  test "second stage" do
    assert Solver.solve_second() == 1149
  end
end
