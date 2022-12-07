defmodule AdventOfCode.Y2022.Day07Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2022.Day07, as: Solver

  @sample_input """
  $ cd /
  $ ls
  dir a
  14848514 b.txt
  8504156 c.dat
  dir d
  $ cd a
  $ ls
  dir e
  29116 f
  2557 g
  62596 h.lst
  $ cd e
  $ ls
  584 i
  $ cd ..
  $ cd ..
  $ cd d
  $ ls
  4060174 j
  8033020 d.log
  5626152 d.ext
  7214296 k
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 95437
  end

  test "first stage" do
    assert Solver.solve_first() === 1_989_474
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 24_933_642
  end

  test "second stage" do
    assert Solver.solve_second() === 1_111_607
  end
end
