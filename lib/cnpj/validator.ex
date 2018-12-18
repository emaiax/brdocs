defmodule BrDocs.CNPJ.Validator do
  alias BrDocs.Utils

  def validate(%BrDoc{kind: :cnpj, value: ""}), do: false
  def validate(%BrDoc{kind: :cnpj, value: nil}), do: false

  def validate(%BrDoc{kind: :cnpj, value: value}) do
    value = value |> to_string() |> String.replace(~r/\D/, "", global: true)

    first_digit = value
                  |> String.slice(0, 12)
                  |> Utils.make_digit()

    last_digit = value
                 |> String.slice(0, 13)
                 |> Utils.make_digit()

    value == (String.slice(value, 0, 12) <> first_digit <> last_digit)
  end

  def validate(value) do
    value
    |> make_cnpj()
    |> validate()
  end

  defp make_cnpj(value) do
    %BrDoc{kind: :cnpj, value: value}
  end
end
