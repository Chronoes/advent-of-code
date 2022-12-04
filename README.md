# AdventOfCode

[Advent of code](https://adventofcode.com)

Add the file config/config.secret.exs with the contents:
```elixir
import Config

config :advent_of_code_helper,
  session: "<session key>" # Session cookie value from AoC website after you log in
```

To generate new day, run `mix help aoc.gen_day` to get information on how to operate it.

Results of input can be seen using custom script

```bash
# First stage of current day
$ mix run priv/solve_day.exs f
# Second stage of day 10
$ mix run priv/solve_day.exs s 10
# All stages of day 17 year 2017
$ mix run priv/solve_day.exs a 17 2017
```

Tests with `mix test` contain correct solutions to sample inputs and real inputs.

## Example solving process

1. `mix aoc.gen_day` to generate solution and test boilerplate files.
2. Open the generated test file and add sample input and its answer from the website.
3. Open the solution file and start solving.
4. To test the solution, run `mix aoc.test_day` to get test results.
5. When ready to test the real solution, remove `@tag :skip` from first solution test and run the test again.
6. Submit the value to website and continue solving until answer is found.
7. Add the correct answer to test and repeat from 3rd step for the day's second expanded problem.
8. ???
9. Profit
