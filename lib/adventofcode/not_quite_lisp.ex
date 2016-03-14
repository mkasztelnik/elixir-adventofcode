defmodule AdventOfCode.NotQuiteLisp do
  @doc ~S"""
  Santa is trying to deliver presents in a large apartment building, but he
  can't find the right floor - the directions he got are a little confusing.
  He starts on the ground floor (floor 0) and then follows the instructions
  one character at a time.

  An opening parenthesis, (, means he should go up one floor, and a closing
  parenthesis, ), means he should go down one floor.

  The apartment building is very tall, and the basement is very deep; he will
  never find the top or bottom floors.

  ## Examples
    iex> AdventOfCode.NotQuiteLisp.floor("(())")
    0

    iex> AdventOfCode.NotQuiteLisp.floor("()()")
    0

    iex> AdventOfCode.NotQuiteLisp.floor("(((")
    3

    iex> AdventOfCode.NotQuiteLisp.floor("(()(()(")
    3

    iex> AdventOfCode.NotQuiteLisp.floor("))(((((")
    3

    iex> AdventOfCode.NotQuiteLisp.floor("())")
    -1

    iex> AdventOfCode.NotQuiteLisp.floor("))(")
    -1

    iex> AdventOfCode.NotQuiteLisp.floor(")))")
    -3

    iex> AdventOfCode.NotQuiteLisp.floor(")())())")
    -3
  """
  def floor(instruction), do: floor(String.codepoints(instruction), 0)

  defp floor([], current), do: current
  defp floor(["(" | tail], current), do: floor(tail, current + 1)
  defp floor([")" | tail], current), do: floor(tail, current - 1)

  @doc ~S"""
  Now, given the same instructions, find the position of the first character
  that causes him to enter the basement(floor -1). The first character in the
  instructions has position 1, the second character has position 2, and so on.

  ## Examples
    iex> AdventOfCode.NotQuiteLisp.enter_basement_at(")")
    1

    iex> AdventOfCode.NotQuiteLisp.enter_basement_at("()())")
    5
  """
  def enter_basement_at(instruction),
    do: enter_basement_at(String.codepoints(instruction), 0, 0)

  defp enter_basement_at(_, -1, step),
    do: step
  defp enter_basement_at([], _, _),
    do: 0
  defp enter_basement_at(["(" | tail], floor, step),
    do: enter_basement_at(tail, floor + 1, step + 1)
  defp enter_basement_at([")" | tail], floor, step),
    do: enter_basement_at(tail, floor - 1, step + 1)
end
