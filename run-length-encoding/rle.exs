defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.codepoints
    |> rle([])
    |> Enum.map(&do_map/1)
    |> Enum.join
  end

  def do_map({chr, 1}), do: "#{chr}"
  def do_map({chr, cnt}), do: "#{cnt}#{chr}"

  defp rle([], out), do: Enum.reverse out
  defp rle([h|t], [{h, c}|out]), do: rle(t, [{h, c+1}|out])
  defp rle([h|t], out), do: rle(t, [{h, 1}|out])  

  @spec decode(String.t) :: String.t
  def decode(string) do
    ~r/(\d+)([^\d])/
    |> Regex.scan(string)
    |> Enum.map(fn ([_, cnt, chr]) -> String.duplicate(chr, to_int(cnt)) end)
    |> Enum.join
  end

  defp to_int(string), do: string |> Integer.parse |> elem(0)
end