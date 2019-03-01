defmodule BrDocs.CPF.Validator do
  @moduledoc ~S"""
  CPF Validator.
  """

  alias BrDocs.{Doc, Utils}

  @doc """
  Validates a `BrDocs.Doc` CPF value against CPF validation rules. Returns a boolean.

  This function accepts either a string containing the CPF value or a `BrDocs.Doc`.

  ## Examples

        iex> BrDocs.CPF.Validator.validate("")
        false

        iex> BrDocs.CPF.Validator.validate(nil)
        false

        iex> BrDocs.CPF.Validator.validate("123")
        false

        iex> BrDocs.CPF.Validator.validate("11144477730")
        false

        iex> BrDocs.CPF.Validator.validate("111.444.777-30")
        false

        iex> BrDocs.CPF.Validator.validate("11144477735")
        true

        iex> BrDocs.CPF.Validator.validate("111.444.777-35")
        true

        iex> BrDocs.CPF.Validator.validate(%BrDocs.Doc{kind: :cpf, value: ""})
        false

        iex> BrDocs.CPF.Validator.validate(%BrDocs.Doc{kind: :cpf, value: nil})
        false

        iex> BrDocs.CPF.Validator.validate(%BrDocs.Doc{kind: :cpf, value: "123"})
        false

        iex> BrDocs.CPF.Validator.validate(%BrDocs.Doc{kind: :cpf, value: "11144477730"})
        false

        iex> BrDocs.CPF.Validator.validate(%BrDocs.Doc{kind: :cpf, value: "111.444.777-30"})
        false

        iex> BrDocs.CPF.Validator.validate(%BrDocs.Doc{kind: :cpf, value: "11144477735"})
        true

        iex> BrDocs.CPF.Validator.validate(%BrDocs.Doc{kind: :cpf, value: "111.444.777-35"})
        true

  """
  @spec validate(BrDocs.Doc.t()) :: boolean()
  def validate(%Doc{kind: :cpf, value: ""}), do: false
  def validate(%Doc{kind: :cpf, value: nil}), do: false

  def validate(%Doc{kind: :cpf, value: value}) do
    value = value |> to_string() |> String.replace(~r/\D/, "", global: true)

    first_digit =
      value
      |> String.slice(0, 9)
      |> Utils.make_digit()

    last_digit =
      value
      |> String.slice(0, 10)
      |> Utils.make_digit()

    value == String.slice(value, 0, 9) <> first_digit <> last_digit
  end

  @spec validate(String.t()) :: boolean()
  def validate(value) do
    value
    |> make_cpf()
    |> validate()
  end

  defp make_cpf(value) do
    %Doc{kind: :cpf, value: value}
  end
end
