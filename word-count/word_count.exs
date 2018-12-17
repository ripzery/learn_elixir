defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.split(~r/[:!&@$%^,_\s]/, trim: true)
    |> Enum.map(&String.downcase(&1))
    |> Enum.reduce(%{}, &do_count/2)
  end
  

  def do_count(x, acc) do
    cond do
      acc[x] == nil -> Map.put_new(acc, x, 1)
      true -> Map.put(acc, x, acc[x] + 1)
    end
  end
end
