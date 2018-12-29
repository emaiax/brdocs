defmodule BrDocs.CNPJ.Generator do
  @moduledoc ~S"""
  CNPJ Generator.
  """

  alias BrDocs.{BrDoc, Utils}

  alias BrDocs.CNPJ.Formatter

  @doc """
  Used mostly for testing, yet you can generate a valid CNPJ. Returns a `BrDocs.BrDoc`.

  ## Options

    * `formatted` - a boolean to format the doc after generation. Defaults to `false`.

  ## Examples

        iex> BrDocs.CNPJ.Generator.generate()
        %BrDocs.BrDoc{kind: :cnpj, value: "11444777000161"}

        iex> BrDocs.CNPJ.Generator.generate(formatted: true)
        %BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}

  """
  def generate(opts \\ [formatted: false])

  def generate(formatted: true), do: generate() |> Formatter.format()

  def generate(formatted: false) do
    doc = Utils.generate_random_numbers(8) <> "0001"

    # 1st verification digit
    doc = doc <> Utils.make_digit(doc)
    # 2nd verification digit
    doc = doc <> Utils.make_digit(doc)

    %BrDoc{kind: :cnpj, value: doc}
  end
end
