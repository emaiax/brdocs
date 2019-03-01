defmodule BrDocs.CNPJ.Validator do
  @moduledoc ~S"""
  CNPJ Validator.
  """

  alias BrDocs.{Doc, Utils}

  @doc """
  Validates a `BrDocs.Doc` CNPJ value against CNPJ validation rules. Returns a boolean.

  This function accepts either a string containing the CNPJ value or a `BrDocs.Doc`.

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

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.Doc{kind: :cnpj, value: ""})
        false

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.Doc{kind: :cnpj, value: nil})
        false

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.Doc{kind: :cnpj, value: "123"})
        false

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.Doc{kind: :cnpj, value: "11444777000160"})
        false

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-60"})
        false

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.Doc{kind: :cnpj, value: "11444777000161"})
        true

        iex> BrDocs.CNPJ.Validator.validate(%BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"})
        true

  """
  @spec validate(BrDocs.Doc.t()) :: boolean()
  def validate(%Doc{kind: :cnpj, value: ""}), do: false
  def validate(%Doc{kind: :cnpj, value: nil}), do: false

  def validate(%Doc{kind: :cnpj, value: value}) do
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

  @spec validate(String.t()) :: boolean()
  def validate(value) do
    value
    |> make_cnpj()
    |> validate()
  end

  defp make_cnpj(value) do
    %Doc{kind: :cnpj, value: value}
  end
end
