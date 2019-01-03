defmodule Roman do
  @alphabets %{
    1 => "I",
    5 => "V",
    10 => "X",
    50 => "L",
    100 => "C",
    500 => "D",
    1000 => "M"
  }

  @subtracted_alphabets %{
    4 => "IV",
    9 => "IX",
    40 => "XL",
    90 => "XC",
    400 => "CD",
    900 => "CM",
  }

  @doc """
    Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    number
    |> decompose
    |> Enum.map_join(&convert/1)
  end

   @doc """
    Decompose the number into list of place value.

    ## Example

    iex> Roman.decompose(1999)
    [1000, 900, 90, 9]
  """
  def decompose(number) do
    %{numbers: decomposed_numbers} = number
    |> Integer.digits
    |> Enum.reverse
    |> Enum.reduce(%{decimal: 1, numbers: []}, &do_decompose/2)

    decomposed_numbers
  end

  defp do_decompose(x, acc) do
    %{decimal: d, numbers: n} = acc
    %{decimal: d * 10, numbers: [(x * d)] ++ n}
  end

  defp convert(number) do
    cond do
      @alphabets[number] != nil -> @alphabets[number]
      @subtracted_alphabets[number] != nil -> @subtracted_alphabets[number]
      true -> number |> do_convert(find_base_alphabet(number), find_first_number(number))
    end
  end

  defp do_convert(number, %{key: alphabet_key, value: alphabet_value}, first_number) when first_number > 5 do
    alphabet_value <> do_convert(number - alphabet_key, find_base_alphabet(number - alphabet_key), first_number - 5)
  end

  defp do_convert(number, %{key: alphabet_key, value: alphabet_value}, _) do
    alphabet_value 
    |> String.duplicate(number / alphabet_key |> round)
  end

  defp find_base_alphabet(number) do
    first_number = find_first_number(number)
    minimum_place_value = :math.pow(10, count_digits(number) - 1) |> round
    key = cond do
      first_number > 5 -> 5 * minimum_place_value
      true -> minimum_place_value
    end
    %{key: key, value: @alphabets[key]}
  end

  defp find_first_number(number) do
    number 
    |> Integer.digits 
    |> Enum.at(0)
  end

  defp count_digits(number) do
    number 
    |> Integer.digits 
    |> Enum.count
  end
end
