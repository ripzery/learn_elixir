defmodule BeerSong do

  @doc """
  Get a single verse of the beer song when no more bottles of beer.
  """
  @spec verse(integer) :: String.t()
  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  @doc """
  Get a single verse of the beer song when there's only 1 bottle of beer left.
  """
  @spec verse(integer) :: String.t()
  def verse(1) do
    """
    1 bottle of beer on the wall, 1 bottle of beer.
    Take it down and pass it around, no more bottles of beer on the wall.
    """
  end

  @doc """
  Get a single verse of the beer song when there's 2 bottles of beer left.
  """
  @spec verse(integer) :: String.t()
  def verse(2) do
    """
    2 bottles of beer on the wall, 2 bottles of beer.
    Take one down and pass it around, 1 bottle of beer on the wall.
    """
  end

  @doc """
  Get a single verse of the beer song when there's more than 2 bottle of beer left.
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    """
    #{number} bottles of beer on the wall, #{number} bottles of beer.
    Take one down and pass it around, #{number - 1} bottles of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    Enum.map_join(range, &do_lyrics/1)
    |> String.slice(0..-2) # Remove the last \n
  end

  defp do_lyrics(round) do
    verse(round) <> "\n"
  end
end
