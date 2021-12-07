defmodule AdventOfCode.Y2020.Day15Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day15, as: Solver

  @sample_inputs [
    {"0,3,6", "436", "175594"},
    {"1,3,2", "1", "2578"},
    {"2,1,3", "10", "3544142"},
    {"1,2,3", "27", "261214"},
    {"2,3,1", "78", "6895259"},
    {"3,2,1", "438", "18"},
    {"3,1,2", "1836", "362"}
  ]

  test "first stage sample" do
    Enum.each(@sample_inputs, fn {input, result1, _result2} ->
      assert Solver.solve_first(input) === result1
    end)
  end

  test "first stage" do
    assert Solver.solve_first() === "1522"
  end

  @tag :skip
  test "second stage sample" do
    Enum.each(@sample_inputs, fn {input, _result1, result2} ->
      assert Solver.solve_second(input) === result2
    end)
  end

  @tag :skip
  test "second stage" do
    assert Solver.solve_second() === true
  end
end
