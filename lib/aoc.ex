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
end
