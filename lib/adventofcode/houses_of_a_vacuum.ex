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

  iex> AdventOfCode.HousesOfAVacuum.size(">")
  2

  ^>v< delivers presents to 4 houses in a square, including twice to the house
  at his starting/ending location.

  iex> AdventOfCode.HousesOfAVacuum.size("^>v<")
  4

  ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2
  houses.

  iex> AdventOfCode.HousesOfAVacuum.size("^v^v^v^v^v")
  2
  """
  def size(instructions) do
    instructions
    |> String.codepoints
    |> visit_house({0, 0}, MapSet.new)
    |> MapSet.size
  end

  defp visit_house([], house, visited) do
    MapSet.put(visited, house)
  end

  defp visit_house(["<" | rest], {x, y} = house, visited) do
    visit_house(rest, {x - 1, y}, MapSet.put(visited, house))
  end
  defp visit_house([">" | rest], {x, y} = house, visited) do
    visit_house(rest, {x + 1, y}, MapSet.put(visited, house))
  end
  defp visit_house(["^" | rest], {x, y} = house, visited) do
    visit_house(rest, {x, y + 1}, MapSet.put(visited, house))
  end
  defp visit_house(["v" | rest], {x, y} = house, visited) do
    visit_house(rest, {x, y - 1}, MapSet.put(visited, house))
  end
end
