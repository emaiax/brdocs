defmodule BrDocs do
  @moduledoc ~S"""
  Generation, validation and formatting for Brazilian docs.

  Currently supported docs:

  * `CPF` it's a Brazilian identification number for individuals (like SSN, in USA).
  * `CNPJ` it's a Brazilian identification number for companies.
  """

  alias BrDocs.BrDoc

  @doc """
  Used mostly for testing, yet you can generate a valid doc. Returns a `BrDocs.BrDoc`.

  The kind must be one of #{BrDoc.formatted_available_docs()}.

  ## Options

    * `formatted` - a boolean to format the doc after generation. Defaults to `false`.

  ## Examples

        iex> BrDocs.generate(:cpf)
        %BrDocs.BrDoc{kind: :cpf, value: "12345678909"}

        iex> BrDocs.generate(:cpf, formatted: true)
        %BrDocs.BrDoc{kind: :cpf, value: "123.456.789-09"}

        iex> BrDocs.generate(:cnpj)
        %BrDocs.BrDoc{kind: :cnpj, value: "11444777000161"}

        iex> BrDocs.generate(:cnpj, formatted: true)
        %BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}

  """
  def generate(kind, opts \\ [formatted: false])

  def generate(:cpf, opts), do: BrDocs.CPF.generate(opts)
  def generate(:cnpj, opts), do: BrDocs.CNPJ.generate(opts)

  @doc """
  Formats the value. Returns a formatted `BrDocs.BrDoc`.

  The atom argument must be one of #{BrDoc.formatted_available_docs()}.

  ## Examples

        iex> BrDocs.format("12345678909", :cpf)
        %BrDocs.BrDoc{kind: :cpf, value: "123.456.789-09"}

        iex> BrDocs.format("11444777000161", :cnpj)
        %BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}

  """
  def format(value, :cpf), do: BrDocs.CPF.Formatter.format(value)
  def format(value, :cnpj), do: BrDocs.CNPJ.Formatter.format(value)

  @doc """
  Formats the `BrDocs.BrDoc` value. Returns a formatted `BrDocs.BrDoc`.

  ## Examples

        iex> BrDocs.format(%BrDocs.BrDoc{kind: :cpf, value: "12345678909"})
        %BrDocs.BrDoc{kind: :cpf, value: "123.456.789-09"}

        iex> BrDocs.format(%BrDocs.BrDoc{kind: :cnpj, value: "11444777000161"})
        %BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}

  """
  def format(%BrDoc{kind: :cpf} = brdoc), do: BrDocs.CPF.Formatter.format(brdoc)
  def format(%BrDoc{kind: :cnpj} = brdoc), do: BrDocs.CNPJ.Formatter.format(brdoc)

  @doc """
  Validates the value. Returns a boolean.

  The atom argument must be one of #{BrDoc.formatted_available_docs()}.

  ## Examples

        iex> BrDocs.validate("12345678909", :cpf)
        true

        iex> BrDocs.validate("12345678900", :cpf)
        false

        iex> BrDocs.validate("123.456.789-09", :cpf)
        true

        iex> BrDocs.validate("123.456.789-00", :cpf)
        false

        iex> BrDocs.validate("11444777000161", :cnpj)
        true

        iex> BrDocs.validate("11444777000160", :cnpj)
        false

        iex> BrDocs.validate("11.444.777/0001-61", :cnpj)
        true

        iex> BrDocs.validate("11.444.777/0001-60", :cnpj)
        false

  """
  def validate(value, :cpf), do: BrDocs.CPF.Validator.validate(value)
  def validate(value, :cnpj), do: BrDocs.CNPJ.Validator.validate(value)

  @doc """
  Validates `BrDocs.BrDoc`. Returns a boolean.

  ## Examples

        iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cpf, value: "12345678909"})
        true

        iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cpf, value: "12345678900"})
        false

        iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cpf, value: "123.456.789-09"})
        true

        iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cpf, value: "123.456.789-00"})
        false

        iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cnpj, value: "11444777000161"})
        true

        iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cnpj, value: "11444777000160"})
        false

        iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-61"})
        true

        iex> BrDocs.validate(%BrDocs.BrDoc{kind: :cnpj, value: "11.444.777/0001-60"})
        false

  """
  def validate(%BrDoc{kind: :cpf} = brdoc), do: BrDocs.CPF.Validator.validate(brdoc)
  def validate(%BrDoc{kind: :cnpj} = brdoc), do: BrDocs.CNPJ.Validator.validate(brdoc)
end
