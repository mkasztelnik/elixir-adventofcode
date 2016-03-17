defmodule AdventOfCode.HousesOfAVacuum do
  @doc ~S"""
  Santa is delivering presents to an infinite two-dimensional grid of houses.

  He begins by delivering a present to the house at his starting location, and
  then an elf at the North Pole calls him via radio and tells him where to move
  next. Moves are always exactly one house to the north(^), south(v), east(>),
  or west(<). After each move, he delivers another present to the house at his
  new location.

  However, the elf back at the north pole has had a little too much eggnog, and
  so his directions are a little off, and Santa ends up visiting some houses
  more than once. How many houses receive at least one present?

  ## Examples

  > delivers presents to 2 houses: one at the starting location, and one to the
  east.

  iex> AdventOfCode.HousesOfAVacuum.visited_houses(">")
  2

  ^>v< delivers presents to 4 houses in a square, including twice to the house
  at his starting/ending location.

  iex> AdventOfCode.HousesOfAVacuum.visited_houses("^>v<")
  4

  ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2
  houses.

  iex> AdventOfCode.HousesOfAVacuum.visited_houses("^v^v^v^v^v")
  2
  """
  def visited_houses(instructions) do
    instructions
    |> String.codepoints
    |> visit_house({0, 0}, MapSet.new)
    |> MapSet.size
  end

  defp visit_house([], house, visited) do
    MapSet.put(visited, house)
  end

  defp visit_house([move | rest], house, visited) do
    visit_house(rest, next_house(move, house), MapSet.put(visited, house))
  end

  defp next_house("<", {x, y}), do: {x - 1, y}
  defp next_house(">", {x, y}), do: {x + 1, y}
  defp next_house("^", {x, y}), do: {x, y + 1}
  defp next_house("v", {x, y}), do: {x, y - 1}

  @doc ~S"""
  The next year, to speed up the process, Santa creates a robot version of
  himself, Robo-Santa, to deliver presents with him.

  Santa and Robo-Santa start at the same location(delivering two presents to the
  same starting house), then take turns moving based on instructions from the
  elf, who is eggnoggedly reading from the same script as the previous year.

  This year, how many houses receive at least one present?

  ## Examples

  ^v delivers presents to 3 houses, because Santa goes north, and then
  Robo-Santa goes south.

  iex> AdventOfCode.HousesOfAVacuum.visited_houses_with_robot("^v")
  3

  ^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back
  where they started.

  iex> AdventOfCode.HousesOfAVacuum.visited_houses_with_robot("^>v<")
  3

  ^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction
  and Robo-Santa going the other.)

  iex> AdventOfCode.HousesOfAVacuum.visited_houses_with_robot("^v^v^v^v^v")
  11

  ^ delivers presents to 2 houses, because only Santa goes north.

  iex> AdventOfCode.HousesOfAVacuum.visited_houses_with_robot("^")
  2
  """
  def visited_houses_with_robot(instructions) do
    instructions
    |> String.codepoints
    |> visit_house({0, 0}, {0, 0}, MapSet.new)
    |> MapSet.size
  end

  defp visit_house([], santa_house, robot_house, visited) do
    add_visited(santa_house, robot_house, visited)
  end

  defp visit_house([santa], santa_house, robot_house, visited) do
    visit_house([santa], santa_house, MapSet.put(visited, robot_house))
  end

  defp visit_house([santa, robot | rest], santa_house, robot_house, visited) do
    visit_house(rest, next_house(santa, santa_house),
                next_house(robot, robot_house),
                add_visited(santa_house, robot_house, visited))
  end

  defp add_visited(santa_house, robot_house, visited) do
    visited
    |> MapSet.put(santa_house)
    |> MapSet.put(robot_house)
  end
end
