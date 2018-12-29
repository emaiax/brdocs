defmodule BrDocs.CPF.Generator do
  @moduledoc ~S"""
  CNPJ Generator.
  """

  alias BrDocs.{BrDoc, Utils}

  alias BrDocs.CPF.Formatter

  @doc """
  Used mostly for testing, yet you can generate a valid CPF. Returns a `BrDocs.BrDoc`.

  ## Options

    * `formatted` - a boolean to format the doc after generation. Defaults to `false`.

  ## Examples

        iex> BrDocs.CPF.Generator.generate()
        %BrDocs.BrDoc{kind: :cpf, value: "11144477735"}

        iex> BrDocs.CPF.Generator.generate(formatted: true)
        %BrDocs.BrDoc{kind: :cnpj, value: "111.444.777-35"}

  """
  def generate(opts \\ [formatted: false])

  def generate(formatted: true), do: generate() |> Formatter.format()

  def generate(formatted: false) do
    doc = Utils.generate_random_numbers(9)

    # 1st verification digit
    doc = doc <> Utils.make_digit(doc)
    # 2nd verification digit
    doc = doc <> Utils.make_digit(doc)

    %BrDoc{kind: :cpf, value: doc}
  end
end
