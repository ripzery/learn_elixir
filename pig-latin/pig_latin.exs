defmodule PigLatin do

  @vowels ~w(a e i o u)

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  def translate(phase) do
    if(String.replace(phase, " ", "") === phase) do
      do_translate(phase)
    else
      phase
      |> String.split(" ")
      |> Enum.map_join(" ", &do_translate/1)
    end
  end

  # Start with x and follows by a consonant
  defp do_translate(<< ?x, consonant :: binary-size(1), rest :: binary >>) when consonant not in @vowels, do: "x" <> consonant <> rest <> "ay"

  # Start with y and follows by a consonant
  defp do_translate(<< ?y, consonant :: binary-size(1), rest :: binary >>) when consonant not in @vowels, do: "y" <> consonant <> rest <> "ay"

  # Start with a consonant and follows by "qu"
  defp do_translate(<< consonant :: binary-size(1), ?q, ?u, rest :: binary >>) when consonant not in @vowels, do: do_translate(rest <> consonant <> "qu")

  # Start with a consonant and follows by "y"
  defp do_translate(<< consonant :: binary-size(1), ?y, rest :: binary >>) when consonant not in @vowels, do: do_translate("y" <> rest <> consonant)

  # Start with qu and follows by any
  defp do_translate(<< ?q, ?u, rest :: binary >>), do: do_translate(rest <> "qu")

  # Start with a consonant and follows by any
  defp do_translate(<< consonant :: binary-size(1), rest :: binary >>) when consonant not in @vowels, do: do_translate(rest <> consonant)

  # Start with a vowel and follows by any
  defp do_translate(<< vowel :: binary-size(1), rest :: binary >>) when vowel in @vowels, do: vowel <> rest <> "ay"
end
