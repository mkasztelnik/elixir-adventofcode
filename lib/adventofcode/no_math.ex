defmodule AdventOfCode.NoMath do
  @doc ~S"""
  The elves are running low on wrapping paper, and so they need to submit an
  order for more. They have a list of the dimensions (length l, width w, and
  height h) of each present, and only want to order exactly as much as they
  need.

  Fortunately, every present is a box (a perfect right rectangular prism),
  which makes calculating the required wrapping paper for each gift a little
  easier: find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l.
  The elves also need a little extra paper for each present: the area of the
  smallest side.

  ## Examples

    A present with dimensions 2x3x4 requires 2*6 + 2*12 + 2*8 = 52 square feet
    of wrapping paper plus 6 square feet of slack, for a total of 58 square
    feet.

    iex> AdventOfCode.NoMath.square("2x3x4")
    58

    A present with dimensions 1x1x10 requires 2*1 + 2*10 + 2*10 = 42 square feet
    of wrapping paper plus 1 square foot of slack, for a total of 43 square
    feet.

    iex> AdventOfCode.NoMath.square("1x1x10")
    43
  """
  def square(dimention_str) do
    dimention_str
    |> to_dimentions
    |> do_square
  end

  defp to_dimentions(dimentions_str) do
    dimentions_str
    |> String.split("x")
    |> Enum.map(&(to_i(&1)))
  end

  defp to_i(str) do
    case Integer.parse(str) do
      {:error, _} -> raise("ups wrong int format")
      {i, _} -> i
    end
  end

  defp do_square([l, w, h]) do
    sizes = [s1, s2, s3] = [l*w, w*h, h*l]

    2 * (s1 + s2 + s3) + Enum.min(sizes)
  end

  @doc ~S"""
  Calculate square for all packages.

  ## Examples
    iex> AdventOfCode.NoMath.squares("2x3x4\n1x1x10")
    101
  """
  def squares(dimentions_str) do
    dimentions_str |> sum(&(square(&1)))
  end

  defp sum(dimentions_str, func) do
    dimentions_str
    |> String.split("\n")
    |> Enum.map(func)
    |> Enum.sum
  end

  @doc ~S"""
  The elves are also running low on ribbon. Ribbon is all the same width, so
  they only have to worry about the length they need to order, which they would
  again like to be exact.

  The ribbon required to wrap a present is the shortest distance around its
  sides, or the smallest perimeter of any one face. Each present also requires a
  bow made out of ribbon as well; the feet of ribbon required for the perfect
  bow is equal to the cubic feet of volume of the present. Don't ask how they
  tie the bow, though; they'll never tell.

  For example:

  A present with dimensions 2x3x4 requires 2+2+3+3 = 10 feet of ribbon to wrap
  the present plus 2*3*4 = 24 feet of ribbon for the bow, for a total of 34
  feet.

  iex> AdventOfCode.NoMath.ribbon("2x3x4")
  34

  A present with dimensions 1x1x10 requires 1+1+1+1 = 4 feet of ribbon to wrap
  the present plus 1*1*10 = 10 feet of ribbon for the bow, for a total of 14
  feet.

  iex> AdventOfCode.NoMath.ribbon("1x1x10")
  14
  """
  def ribbon(dimention_str) do
    dimention_str
    |> to_dimentions
    |> do_ribbon
  end

  defp do_ribbon(dimentions) do
    [l, m, h] = Enum.sort(dimentions)

    2 * (l + m) + l * m * h
  end

  @doc ~S"""
  Calculate ribbon for all packages.

  ## Examples
    iex> AdventOfCode.NoMath.ribbons("2x3x4\n1x1x10")
    48
  """
  def ribbons(dimentions_str) do
    dimentions_str |> sum(&(ribbon(&1)))
  end
end
