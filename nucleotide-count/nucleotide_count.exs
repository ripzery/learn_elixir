defmodule NucleotideCount do
  @nucleotides %{?A => 0, ?C => 0, ?G => 0, ?T => 0}

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    strand 
    |> Enum.reduce(@nucleotides, &collect/2)
    |> find_occurrence(nucleotide)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    strand 
    |> Enum.reduce(@nucleotides, &collect/2)
  end

  defp collect(x, acc) do
    cond do
      acc[x] == nil -> Map.put_new(acc, x, 1)
      true -> Map.put(acc, x, acc[x] + 1)
    end
  end

  defp find_occurrence(acc, nucleotide), do: acc[nucleotide]
end
