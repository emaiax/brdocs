defmodule BrDocs.BrDoc do
  @available_docs [:cpf, :cnpj]

  @moduledoc ~S"""
  A struct containing value and kind of the doc.

  * `kind` - An atom to identify which Brazilian doc kind is being held. It must be one of #{formatted_available_docs()}.
  * `value` - A string containing the raw or formatted value of the doc.
  """

  defstruct value: "", kind: nil

  @doc false
  def formatted_available_docs(), do: Enum.map_join(@available_docs, ", ", &("`#{inspect(&1)}`"))
end
