defmodule BrDocs.CPF.Generator do
  alias BrDocs.{BrDoc, Utils}

  alias BrDocs.CPF.Formatter

  def generate(opts \\ [formatted: false])

  def generate(formatted: true), do: generate() |> Formatter.format()

  def generate(formatted: false) do
    doc = Utils.generate_random_numbers(9)

    doc = doc <> Utils.make_digit(doc) # 1st verification digit
    doc = doc <> Utils.make_digit(doc) # 2nd verification digit

    %BrDoc{kind: :cpf, value: doc}
  end
end
