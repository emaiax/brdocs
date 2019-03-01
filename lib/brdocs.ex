defmodule BrDocs do
  @moduledoc ~S"""
  Generation, validation and formatting for Brazilian docs.

  Currently supported docs:

  * `CPF` it's a Brazilian identification number for individuals (like SSN, in USA).
  * `CNPJ` it's a Brazilian identification number for companies.
  """

  alias BrDocs.Doc

  @doc """
  Used mostly for testing, yet you can generate a valid doc. Returns a `BrDocs.Doc`.

  The kind must be one of #{Doc.formatted_available_docs()}.

  ## Options

    * `formatted` - a boolean to format the doc after generation. Defaults to `false`.

  ## Examples

        iex> BrDocs.generate(:cpf)
        %BrDocs.Doc{kind: :cpf, value: "12345678909"}

        iex> BrDocs.generate(:cpf, formatted: true)
        %BrDocs.Doc{kind: :cpf, value: "123.456.789-09"}

        iex> BrDocs.generate(:cnpj)
        %BrDocs.Doc{kind: :cnpj, value: "11444777000161"}

        iex> BrDocs.generate(:cnpj, formatted: true)
        %BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"}

  """
  @spec generate(atom(), keyword()) :: BrDocs.Doc.t()
  def generate(kind, opts \\ [formatted: false])

  def generate(:cpf, opts), do: BrDocs.CPF.generate(opts)
  def generate(:cnpj, opts), do: BrDocs.CNPJ.generate(opts)

  @doc """
  Formats the value. Returns a formatted `BrDocs.Doc`.

  The atom argument must be one of #{Doc.formatted_available_docs()}.

  ## Examples

        iex> BrDocs.format("12345678909", :cpf)
        %BrDocs.Doc{kind: :cpf, value: "123.456.789-09"}

        iex> BrDocs.format("11444777000161", :cnpj)
        %BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"}

  """
  @spec format(String.t(), atom()) :: BrDocs.Doc.t()
  def format(value, kind)
  def format(value, :cpf), do: BrDocs.CPF.Formatter.format(value)
  def format(value, :cnpj), do: BrDocs.CNPJ.Formatter.format(value)

  @doc """
  Formats the `BrDocs.Doc` value. Returns a formatted `BrDocs.Doc`.

  ## Examples

        iex> BrDocs.format(%BrDocs.Doc{kind: :cpf, value: "12345678909"})
        %BrDocs.Doc{kind: :cpf, value: "123.456.789-09"}

        iex> BrDocs.format(%BrDocs.Doc{kind: :cnpj, value: "11444777000161"})
        %BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"}

  """
  @spec format(BrDocs.Doc.t()) :: BrDocs.Doc.t()
  def format(%Doc{kind: :cpf} = brdoc), do: BrDocs.CPF.Formatter.format(brdoc)
  def format(%Doc{kind: :cnpj} = brdoc), do: BrDocs.CNPJ.Formatter.format(brdoc)

  @doc """
  Validates the value. Returns a boolean.

  The atom argument must be one of #{Doc.formatted_available_docs()}.

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
  @spec validate(String.t(), atom()) :: BrDocs.Doc.t()
  def validate(value, kind)
  def validate(value, :cpf), do: BrDocs.CPF.Validator.validate(value)
  def validate(value, :cnpj), do: BrDocs.CNPJ.Validator.validate(value)

  @doc """
  Validates `BrDocs.Doc`. Returns a boolean.

  ## Examples

        iex> BrDocs.validate(%BrDocs.Doc{kind: :cpf, value: "12345678909"})
        true

        iex> BrDocs.validate(%BrDocs.Doc{kind: :cpf, value: "12345678900"})
        false

        iex> BrDocs.validate(%BrDocs.Doc{kind: :cpf, value: "123.456.789-09"})
        true

        iex> BrDocs.validate(%BrDocs.Doc{kind: :cpf, value: "123.456.789-00"})
        false

        iex> BrDocs.validate(%BrDocs.Doc{kind: :cnpj, value: "11444777000161"})
        true

        iex> BrDocs.validate(%BrDocs.Doc{kind: :cnpj, value: "11444777000160"})
        false

        iex> BrDocs.validate(%BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-61"})
        true

        iex> BrDocs.validate(%BrDocs.Doc{kind: :cnpj, value: "11.444.777/0001-60"})
        false

  """
  @spec validate(BrDocs.Doc.t()) :: BrDocs.Doc.t()
  def validate(%Doc{kind: :cpf} = brdoc), do: BrDocs.CPF.Validator.validate(brdoc)
  def validate(%Doc{kind: :cnpj} = brdoc), do: BrDocs.CNPJ.Validator.validate(brdoc)
end
