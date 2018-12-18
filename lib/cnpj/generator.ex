defmodule BrDocs.CNPJ.Generator do
  alias BrDocs.Utils
  alias BrDocs.CNPJ.Formatter

  def generate(opts \\ [formatted: false])

  def generate(formatted: true), do: generate() |> Formatter.format()

  def generate(formatted: false) do
    doc = Utils.generate_random_numbers(8) <> "0001"

    doc = doc <> Utils.make_digit(doc) # 1st verification digit
    doc = doc <> Utils.make_digit(doc) # 2nd verification digit

    %BrDoc{kind: :cnpj, value: doc}
  end
end
