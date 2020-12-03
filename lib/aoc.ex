defmodule Aoc do

  def day_one do
    inputs =
      File.read!("inputs/one")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    [{a, b} | _] = for x <- inputs, y <- inputs, x + y == 2020, do: {x, y}
    IO.puts(a * b)

    [{a, b, c} | _] = for x <- inputs, y <- inputs, z <- inputs, x + y + z == 2020, do: {x, y, z}
    IO.puts(a * b * c)
  end

  def day_two do
    inputs = File.stream!("inputs/two")

    parse_line =
      fn (line) ->
        Regex.run(~r/^(\d+)-(\d+) ([a-z]): ([a-z]+)$/, line, capture: :all_but_first)
      end

    valid =
      fn (passwd, letter, position) ->
        if String.at(passwd, String.to_integer(position) - 1) != letter, do: 1, else: 0
      end

    inputs
    |> Stream.filter(
      fn (line) ->
        [min_count, max_count, letter, passwd] = parse_line.(line)
        count =
          String.graphemes(passwd)
          |> Enum.frequencies()
          |> Map.get(letter, 0)
        count >= String.to_integer(min_count) && count <= String.to_integer(max_count)
      end
    )
    |> Enum.count()
    |> IO.puts()

    inputs
    |> Enum.count(
      fn line ->
        [pos1, pos2, letter, passwd] = parse_line.(line)
        valid.(passwd, letter, pos1) + valid.(passwd, letter, pos2) == 1
      end
    )
    |> IO.puts()
  end
end
