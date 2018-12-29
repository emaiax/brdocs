defmodule BrDocs.BrDoc do
  @available_docs [:cpf, :cnpj]

  @moduledoc """
  A struct containing value and kind of the doc.

  * `kind` - An atom to identify which Brazilian doc kind is being held. It must be one of `:cpf`, `:cnpj`.
  * `value` - A string containing the raw or formatted value of the doc.
  """

  @type t() :: %BrDocs.BrDoc{kind: atom(), value: String.t()}

  defstruct value: "", kind: nil

  @doc false
  def formatted_available_docs(), do: Enum.map_join(@available_docs, ", ", &"`#{inspect(&1)}`")
end
