defmodule BrDocs.CNPJ.Generator do
  @moduledoc ~S"""
  CNPJ Generator.
  """

  alias BrDocs.{Doc, Utils}

  alias BrDocs.CNPJ.Formatter

  @doc """
  Used mostly for testing, yet you can generate a valid CNPJ. Returns a `BrDocs.Doc`.

  ## Options

    * `formatted` - a boolean to format the doc after generation. Defaults to `false`.

  ## Examples

        iex> BrDocs.CNPJ.Generator.generate()
        %BrDocs.Doc{kind: :cnpj, value: "11444777000161"}

        iex> BrDocs.CNPJ.Generator.generate(formatted: true)
        %BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"}

  """
  @spec generate(keyword(boolean())) :: BrDocs.Doc.t()
  def generate(opts \\ [formatted: false])

  def generate(formatted: true), do: Formatter.format(generate())

  def generate(formatted: false) do
    doc = Utils.generate_random_numbers(8) <> "0001"

    # 1st verification digit
    doc = doc <> Utils.make_digit(doc)
    # 2nd verification digit
    doc = doc <> Utils.make_digit(doc)

    %Doc{kind: :cnpj, value: doc}
  end
end
