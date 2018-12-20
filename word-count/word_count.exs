defmodule Words do
  
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.split(~r/[:!&@$%^,_\s]/, trim: true)
    |> Enum.map(&String.downcase/1)
    |> Enum.reduce(%{}, &do_count/2)
  end
  
  defp do_count(x, acc), do: Map.update(acc, x, 1, &(&1 + 1))
end
