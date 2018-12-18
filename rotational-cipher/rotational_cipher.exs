defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text)
    |> Enum.map(&do_rotate(&1, shift))
    |> Enum.join
  end

  def do_rotate(x, shift) when x >= ?a and x + shift > ?z do
    << x + shift - 26 >>
  end

  def do_rotate(x, shift) when x >= ?a and x + shift <= ?z do
    << x + shift >>
  end

  def do_rotate(x, shift) when x >= ?A and x + shift > ?Z do
    << x + shift - 26 >>
  end

  def do_rotate(x, shift) when x >= ?A and x + shift <= ?Z do
    << x + shift >>
  end

  def do_rotate(x, _), do: << x >>
  
end
