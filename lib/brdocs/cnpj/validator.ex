defmodule BrDocs.CNPJ.Validator do
  @moduledoc ~S"""
  CNPJ Validator.
  """

  alias BrDocs.{BrDoc, Utils}

  @doc """
  Validates a `BrDocs.BrDoc` CNPJ value against CNPJ validation rules. Returns a boolean.

  This function accepts either a string containing the CNPJ value or a `BrDocs.BrDoc`.

  ## Examples

        iex> BrDocs.CNPJ.Validator.validate("")
        false

        iex> BrDocs.CNPJ.Validator.validate(nil)
        false

        iex> BrDocs.CNPJ.Validator.validate("123")
        false

        iex> BrDocs.CNPJ.Validator.validate("11444777000160")
        false

        iex> BrDocs.CNPJ.Validator.validate("11.444.777/0001-60")
        false

        iex> BrDocs.CNPJ.Validator.validate("11444777000161")
        true

        iex> BrDocs.CNPJ.Validator.validate("11.444.777/0001-61")
        true

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.BrDoc{kind: :cnpj, value: ""})
        false

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.BrDoc{kind: :cnpj, value: nil})
        false

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.BrDoc{kind: :cnpj, value: "123"})
        false

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.BrDoc{kind: :cnpj, value: "11444777000160"})
        false

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-60"})
        false

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.BrDoc{kind: :cnpj, value: "11444777000161"})
        true

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"})
        true

  """
  def validate(%BrDoc{kind: :cnpj, value: ""}), do: false
  def validate(%BrDoc{kind: :cnpj, value: nil}), do: false

  def validate(%BrDoc{kind: :cnpj, value: value}) do
    value = value |> to_string() |> String.replace(~r/\D/, "", global: true)

    first_digit =
      value
      |> String.slice(0, 12)
      |> Utils.make_digit()

    last_digit =
      value
      |> String.slice(0, 13)
      |> Utils.make_digit()

    value == String.slice(value, 0, 12) <> first_digit <> last_digit
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
