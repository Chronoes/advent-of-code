defmodule AdventOfCode.Y2022.Day11 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2022/day/11
  """

  defmodule Monkey do
    defstruct [:id, :items, :operation, :throw_to, :inspections]

    @type id() :: non_neg_integer()
    @type t() :: %__MODULE__{
            id: id(),
            items: [pos_integer()],
            operation: (pos_integer(), pos_integer() -> pos_integer()),
            throw_to: (pos_integer() -> id()),
            inspections: non_neg_integer()
          }

    def from_text(text) do
      parse_int = &elem(Integer.parse(&1), 0)
      [id, items, operation, test_value, if_true, if_false] = String.split(text, "\n")
      id = String.replace_leading(id, "Monkey ", "") |> String.trim_trailing(":") |> parse_int.()

      items =
        String.replace_leading(items, "  Starting items: ", "")
        |> String.split(", ")
        |> Enum.map(parse_int)

      operation =
        String.replace_leading(operation, "  Operation: new = ", "") |> parse_operation()

      test_value = String.replace_leading(test_value, "  Test: divisible by ", "") |> parse_int.()

      if_true =
        String.replace_leading(if_true, "    If true: throw to monkey ", "") |> parse_int.()

      if_false =
        String.replace_leading(if_false, "    If false: throw to monkey ", "") |> parse_int.()

      throw_to = fn
        worry_value when rem(worry_value, test_value) == 0 -> if_true
        _ -> if_false
      end

      %__MODULE__{
        id: id,
        items: items,
        operation: operation,
        throw_to: throw_to,
        inspections: 0
      }
    end

    defp parse_operation(operation) do
      [a, operator, b] = String.split(operation)

      op =
        case operator do
          "*" -> &(&1 * &2)
          "+" -> &(&1 + &2)
        end

      b_val =
        case Integer.parse(b) do
          :error -> &Function.identity/1
          {nr, _} -> fn _ -> nr end
        end

      case Integer.parse(a) do
        :error -> &op.(&1, b_val.(&1))
        {nr, _} -> &op.(nr, b_val.(&1))
      end
    end

    def inspect_items(%__MODULE__{} = monkey) do
      inspect_items(monkey, monkey.items)
    end

    defp inspect_items(_monkey, []), do: []

    defp inspect_items(%__MODULE__{} = monkey, [item | items]) do
      worry_level = Integer.floor_div(monkey.operation.(item), 3)
      [{worry_level, monkey.throw_to.(worry_level)} | inspect_items(monkey, items)]
    end
  end

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&Monkey.from_text/1)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> run_inspection_rounds(20)
    |> Enum.map(& &1.inspections)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  @spec run_inspection_rounds([Monkey.t()], non_neg_integer) :: any
  def run_inspection_rounds(monkeys, 0), do: monkeys

  def run_inspection_rounds(monkeys, rounds_left) do
    round_result =
      0..(length(monkeys) - 1)
      |> Enum.reduce(monkeys, fn idx, acc ->
        monkey = Enum.at(acc, idx)
        thrown_to = Monkey.inspect_items(monkey)

        Enum.map(acc, fn
          inspector when inspector == monkey ->
            %{
              inspector
              | items: [],
                inspections: inspector.inspections + length(thrown_to)
            }

          recipient ->
            case Enum.filter(thrown_to, fn {_worry_value, id} -> id == recipient.id end) do
              [] ->
                recipient

              items ->
                %{recipient | items: Enum.concat(recipient.items, Enum.map(items, &elem(&1, 0)))}
            end
        end)
      end)

    # Enum.map(round_result, fn monkey ->
    #   "Monkey #{monkey.id}: #{Enum.map(monkey.items, &to_string/1) |> Enum.join(", ")}\n"
    # end)
    # |> Enum.join()
    # |> IO.write()

    run_inspection_rounds(round_result, rounds_left - 1)
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 11)
    content
  end
end
