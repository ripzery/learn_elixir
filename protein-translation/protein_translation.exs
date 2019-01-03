defmodule ProteinTranslation do

  @map_codon_protein %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> String.to_charlist
    |> Enum.chunk_every(3)
    |> to_strings
    |> to_proteins([])
  end

  defp to_strings(charlist), do: Enum.map(charlist, &to_string/1)

  defp to_proteins([], proteins) do
    {:ok, Enum.reverse proteins}
  end

  defp to_proteins([codon|codons], proteins) do
    {status, protein} = of_codon(codon)

    cond do
      status === :error -> {:error, "invalid RNA"}
      protein === "STOP" -> to_proteins([], proteins)
      true -> to_proteins(codons, [protein] ++ proteins)
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    if Map.has_key?(@map_codon_protein, codon) do
      {:ok, @map_codon_protein[codon]}
    else
      {:error, "invalid codon"}
    end
  end
end
