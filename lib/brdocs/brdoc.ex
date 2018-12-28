defmodule BrDocs.BrDoc do
  @available_docs [:cpf, :cnpj]

  @moduledoc """
  A struct containing value and kind of the doc.

  * `kind` - An atom to identify which Brazilian doc kind is being held. It must be one of #{Enum.map_join(@available_docs, ", ", &"`#{inspect &1}`")}.
  * `value` - A string containing the raw or formatted value of the doc.
  """

  defstruct value: "", kind: nil

  @doc false
  def available_docs, do: @available_docs
end
