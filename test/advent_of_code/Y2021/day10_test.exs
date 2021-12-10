defmodule AdventOfCode.Y2021.Day10Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2021.Day10, as: Solver

  @sample_input """
  [({(<(())[]>[[{[]{<()<>>
  [(()[<>])]({[<{<<[]>>(
  {([(<{}[<>[]}>{[]{[(<()>
  (((({<>}<{<{<>}{[]{[]{}
  [[<[([]))<([[{}[[()]]]
  [{[{({}]{}}([{[{{{}}([]
  {<[[]]>}<{[{[{[]{()[[[]
  [<(<(<(<{}))><([]([]()
  <{([([[(<>()){}]>(<<{{
  <{([{{}}[<[[[<>{}]]]>[]]
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 26397
  end

  test "first stage" do
    assert Solver.solve_first() === 469_755
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 288_957
  end

  test "second stage" do
    assert Solver.solve_second() === 2_762_335_572
  end
end
