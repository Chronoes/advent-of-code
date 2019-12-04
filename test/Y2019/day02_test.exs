defmodule AdventOfCode.Y2019.Day02Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2019.Day02, as: Solver

  test "first stage" do
    assert Solver.solve(:first) == 3_085_697
  end

  test "second stage" do
    assert Solver.solve(:second)
  end

  test "sample program" do
    assert Solver.read_instructions([1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50]) ==
             [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]
  end

  test "small simple programs" do
    [
      {[1, 0, 0, 0, 99], [2, 0, 0, 0, 99]},
      {[2, 3, 0, 3, 99], [2, 3, 0, 6, 99]},
      {[2, 4, 4, 5, 99, 0], [2, 4, 4, 5, 99, 9801]},
      {[1, 1, 1, 4, 99, 5, 6, 0, 99], [30, 1, 1, 4, 2, 5, 6, 0, 99]}
    ]
    |> Enum.each(fn {input, expected} ->
      assert Solver.read_instructions(input) == expected
    end)
  end
end
