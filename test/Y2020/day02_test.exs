defmodule AdventOfCode.Y2020.Day02Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day02, as: Solver

  test "first stage" do
    assert Solver.solve_first() == 422
  end

  test "first stage sample" do
    assert Solver.solve_first("""
               1-3 a: abcde
           1-3 b: cdefg
           2-9 c: ccccccccc
           """)
  end

  test "second stage" do
    assert Solver.solve_second() == 451
  end
end
