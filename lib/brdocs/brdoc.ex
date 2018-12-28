defmodule BrDocs.BrDoc do
  @docs [:cpf, :cnpj]

  @moduledoc """
  A struct containing value and kind of the doc.

  * `kind` - An atom to identify which Brazilian doc kind is being held: #{Enum.map_join(@docs, ", ", &"`#{inspect &1}`")}.
  * `value` - A string containing the raw or formatted value of the doc.
  """

  defstruct value: "", kind: nil
end
