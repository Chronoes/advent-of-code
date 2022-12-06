defmodule AdventOfCode.Y2022.Day06Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2022.Day06, as: Solver

  @sample_inputs [
    {"mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7, 19},
    {"bvwbjplbgvbhsrlpgdmjqwftvncz", 5, 23},
    {"nppdvjthqldpwncqszvftbrmjlhg", 6, 23},
    {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10, 29},
    {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11, 26}
  ]

  test "first stage sample" do
    Enum.each(@sample_inputs, fn {input, ans1, _ans2} ->
      assert Solver.solve_first(input) === ans1
    end)
  end

  test "first stage" do
    assert Solver.solve_first() === 1282
  end

  test "second stage sample" do
    Enum.each(@sample_inputs, fn {input, _ans1, ans2} ->
      assert Solver.solve_second(input) === ans2
    end)
  end

  test "second stage" do
    assert Solver.solve_second() === 3513
  end
end
