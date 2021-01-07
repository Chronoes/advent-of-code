defmodule AdventOfCode.Day do
  defmacro __using__(_) do
    quote do
      @behaviour AdventOfCode.Day

      @spec solve_first :: any
      def solve_first() do
        solve_first(read_input())
      end

      @spec solve_second :: any
      def solve_second() do
        solve_second(read_input())
      end
    end
  end

  @callback solve_first(any) :: any
  @callback solve_second(any) :: any
  @callback read_input :: any
end
