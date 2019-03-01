defmodule BrDocs.CNPJ do
  @moduledoc ~S"""
  Generation, validation and formatting for Brazilian CNPJ.

  In Brazil, the CNPJ is an unique 14 numbers length which identifies a company in the Receita Federal (like IRS, in USA).
  """

  @doc """
  Formats a CNPJ value into CNPJ format. Returns a formatted `BrDocs.Doc`.

  Delegates the formatting to `BrDocs.CNPJ.Formatter.format/1`.
  """
  @spec format(String.t() | BrDocs.Doc.t()) :: BrDocs.Doc.t()
  defdelegate format(value), to: BrDocs.CNPJ.Formatter

  @doc """
  Validates a CNPJ value against CNPJ validation rules. Returns a boolean.

  Delegates the validation to `BrDocs.CNPJ.Validator.validate/1`.
  """
  @spec validate(String.t() | BrDocs.Doc.t()) :: BrDocs.Doc.t()
  defdelegate validate(value), to: BrDocs.CNPJ.Validator

  @doc """
  Used mostly for testing, yet you can generate a valid CNPJ. Returns a `BrDocs.Doc`.

  Delegates the generation to `BrDocs.CNPJ.Generator.generate/1`.
  """
  @spec generate(keyword()) :: BrDocs.Doc.t()
  defdelegate generate(opts \\ [formatted: false]), to: BrDocs.CNPJ.Generator
end
