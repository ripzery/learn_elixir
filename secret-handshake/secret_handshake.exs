defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  use Bitwise

  @wink 0b00001
  @double_blink 0b00010
  @close_eyes 0b00100
  @jump 0b01000
  @reverse 0b10000

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    put_action(code, [])
  end

  defp put_action(code, list) when (code &&& @wink) === @wink, do: put_action(code ^^^ @wink, ["wink"] ++ list)
  defp put_action(code, list) when (code &&& @double_blink) === @double_blink, do: put_action(code ^^^ @double_blink, ["double blink"] ++ list)
  defp put_action(code, list) when (code &&& @close_eyes) === @close_eyes, do: put_action(code ^^^ @close_eyes, ["close your eyes"] ++ list)
  defp put_action(code, list) when (code &&& @jump) === @jump, do: put_action(code ^^^ @jump, ["jump"] ++ list)
  defp put_action(code, list) when (code &&& @reverse) === @reverse, do: put_action(code ^^^ @reverse, Enum.reverse list)
  defp put_action(code, list), do: Enum.reverse list
end
