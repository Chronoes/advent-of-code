defmodule AdventOfCode.Y2022.Day10 do
  use AdventOfCode.Day
  alias __MODULE__, as: RegisterState

  @moduledoc """
  https://adventofcode.com/2022/day/10
  """

  defstruct x: 1, signal_strength: 0, crt_screen: List.duplicate(?., 40 * 6)

  @type t() :: %__MODULE__{
          x: integer(),
          signal_strength: pos_integer(),
          crt_screen: nonempty_charlist()
        }
  @type action() :: :noop | {:addx, number}

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Stream.flat_map(&process_cmd/1)
    |> Stream.with_index()
  end

  def process_cmd("noop"), do: [:noop]
  def process_cmd("addx " <> value), do: [:noop, {:addx, Integer.parse(value) |> elem(0)}]

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    state =
      prep_input(input)
      |> Enum.reduce(%RegisterState{}, &run_cycle/2)

    state.signal_strength
  end

  @spec run_cycle({action(), integer()}, RegisterState.t()) :: RegisterState.t()
  def run_cycle({:noop, idx}, %RegisterState{} = state) do
    %{state | signal_strength: calc_strength(state, idx + 1)}
  end

  def run_cycle({{:addx, value}, idx}, %RegisterState{} = state) do
    %{state | x: state.x + value, signal_strength: calc_strength(state, idx + 1)}
  end

  @spec calc_strength(%RegisterState{}, integer()) :: integer()
  def calc_strength(%RegisterState{} = state, cycle) when rem(cycle - 20, 40) == 0 do
    state.signal_strength + cycle * state.x
  end

  def calc_strength(%RegisterState{} = state, _cycle), do: state.signal_strength

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    state =
      prep_input(input)
      |> Enum.reduce(%RegisterState{}, &draw_screen/2)

    stringify_crt_screen(state.crt_screen)
  end

  @spec draw_screen({action(), integer()}, RegisterState.t()) :: RegisterState.t()
  def draw_screen({action, idx}, %RegisterState{} = state) do
    # render_sprite_pos(state.x)

    state = draw_pixel(state, idx)
    state = run_cycle({action, idx}, state)

    # render_crt_line(state.crt_screen, Integer.floor_div(idx, 40))
    state
  end

  @spec draw_pixel(RegisterState.t(), integer()) :: RegisterState.t()
  def draw_pixel(state, idx) do
    pos = rem(idx, length(state.crt_screen))
    # IO.write("Position #{pos}\n")

    crt_screen =
      if rem(pos, 40) in (state.x - 1)..(state.x + 1) do
        List.replace_at(state.crt_screen, pos, ?#)
      else
        state.crt_screen
      end

    %{state | crt_screen: crt_screen}
  end

  def stringify_crt_screen(crt_screen, line \\ -1)

  def stringify_crt_screen(crt_screen, -1) do
    crt_screen
    |> Enum.chunk_every(40)
    |> Enum.map(&List.to_string/1)
    |> Enum.join("\n")
  end

  def stringify_crt_screen(crt_screen, line) do
    crt_screen
    |> Enum.slice((line * 40)..((line + 1) * 40))
    |> List.to_string()
  end

  def render_sprite_pos(x) do
    line =
      List.duplicate(?., 40)
      |> List.replace_at(x - 1, ?#)
      |> List.replace_at(x, ?#)
      |> List.replace_at(x + 1, ?#)
      |> List.to_string()

    IO.write("Sprite position: #{line}\n")
  end

  def render_crt_line(crt_screen, line) do
    screen = stringify_crt_screen(crt_screen, line)
    IO.write("Current CRT row: #{screen}\n")
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 10)
    content
  end
end
