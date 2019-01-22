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

  if Code.ensure_loaded?(Ecto) do
    defmodule Type do
      @behaviour Ecto.Type

      alias BrDocs.BrDoc

      def type, do: :map

      # Provide custom casting rules.
      #
      # Accept casting of BrDoc structs as well
      def cast(%BrDocs.BrDoc{} = doc), do: {:ok, doc}
      #
      # Cast map into the BrDoc struct to be used at runtime
      def cast(%{value: value, kind: kind}), do: {:ok, %BrDoc{kind: kind, value: value}}
      #
      # Cast string into the BrDoc struct to be used at runtime
      def cast(value) when is_bitstring(value), do: {:ok, %BrDoc{kind: discover_kind(value), value: value}}

      # When loading data from the database, we are guaranteed to
      # receive a map (as databases are strict) and we will
      # just put the data back into an BrDoc struct to be stored
      # in the loaded schema struct.
      def load(value) do
        {:ok, %BrDoc{kind: discover_kind(value), value: value}}
      end

      # When dumping data to the database, we *expect* an BrDoc struct
      # but any value could be inserted into the schema struct at runtime,
      # so we need to guard against them.
      def dump(%BrDoc{} = doc), do: {:ok, doc.value}
      def dump(_), do: :error

      defp discover_kind(value) do
        value
        |> to_string()
        |> String.replace(~r/\D/, "", global: true)
        |> String.length()
        |> case do
          11 -> :cpf
          14 -> :cnpj
          _ -> :unknown
        end
      end
    end
  end
end
