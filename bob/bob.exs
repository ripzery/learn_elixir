defmodule Bob do
  def hey(input) do
    cond do
      is_question(input) -> "Sure."
      is_yell_question(input) -> "Calm down, I know what I'm doing!"
      is_address_without_saying(input) -> "Fine. Be that way!"
      is_yell(input)  -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp is_yell(input) do
    String.upcase(input) == input 
    && String.downcase(input) != input # To make sure the string is convertable. (Not containing only the number or symbol.)
  end

  defp is_question(input) do
    String.ends_with?(input, "?") 
    && String.capitalize(input) == input
  end

  defp is_yell_question(input) do
    String.upcase(input) == input 
    && String.ends_with?(input, "?") 
  end

  defp is_address_without_saying(input) do
    String.trim(input) == ""
  end
end
