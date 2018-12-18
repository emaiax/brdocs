defmodule BrDocs.CPF.Generator do
  alias BrDocs.Utils
  alias BrDocs.CPF.Formatter

  def generate(opts \\ [formatted: false])

  def generate(formatted: true), do: generate() |> Formatter.format()

  def generate(formatted: false) do
    doc = Enum.map(1..9, fn _ -> Enum.random(0..9) |> to_string() end) |> Enum.join()

    doc = doc <> make_digit(doc) # 1st verification digit
    doc = doc <> make_digit(doc) # 2nd verification digit

    %BrDoc{kind: :cpf, value: doc}
  end

  defp make_digit(value), do: value |> Utils.mod11() |> to_string()
end
