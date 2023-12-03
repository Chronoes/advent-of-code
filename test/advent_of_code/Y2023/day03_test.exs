defmodule AdventOfCode.Y2023.Day03Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2023.Day03, as: Solver

  @sample_input """
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 4361
  end

  test "first stage" do
    assert Solver.solve_first() === 531_932
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 467_835
  end

  test "second stage" do
    assert Solver.solve_second() === 73_646_890
  end
end
