defmodule RNATranscription do
  @relation %{ ?A => 'U', ?T => 'A', ?C => 'G', ?G => 'C'}
  
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) when is_list(dna) do
    dna
    |> Enum.map(&to_rna/1)
    |> Enum.concat
  end

  def to_rna(dna) when is_integer(dna) do
    Map.get(@relation, dna)
  end
end
