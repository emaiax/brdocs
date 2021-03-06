defmodule BrDocs.CPF.Generator do
  @moduledoc ~S"""
  CNPJ Generator.
  """

  alias BrDocs.{Doc, Utils}

  alias BrDocs.CPF.Formatter

  @doc """
  Used mostly for testing, yet you can generate a valid CPF. Returns a `BrDocs.Doc`.

  ## Options

    * `formatted` - a boolean to format the doc after generation. Defaults to `false`.

  ## Examples

        iex> BrDocs.CPF.Generator.generate()
        %BrDocs.Doc{kind: :cpf, value: "11144477735"}

        iex> BrDocs.CPF.Generator.generate(formatted: true)
        %BrDocs.Doc{kind: :cnpj, value: "111.444.777-35"}

  """
  @spec generate(keyword(boolean())) :: BrDocs.Doc.t()
  def generate(opts \\ [formatted: false])

  def generate(formatted: true), do: Formatter.format(generate())

  def generate(formatted: false) do
    doc = Utils.generate_random_numbers(9)

    # 1st verification digit
    doc = doc <> Utils.make_digit(doc)
    # 2nd verification digit
    doc = doc <> Utils.make_digit(doc)

    %Doc{kind: :cpf, value: doc}
  end
end
