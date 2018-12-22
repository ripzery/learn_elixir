defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    collect(list, fun, true, [])
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    collect(list, fun, false, [])
  end

  defp collect([], _, _, collection), do: Enum.reverse collection

  defp collect([elem | rest], fun, expect, collection) do
    item = if fun.(elem) == expect, do: [elem], else: []
    collect(rest, fun, expect, item ++ collection)
  end
end
