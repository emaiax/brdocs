defmodule BrDocs.CPF do
  @moduledoc ~S"""
  Generation, validation and formatting for Brazilian CPF.

  In Brazil, the CPF is an unique 11 numbers length which identifies an individual (like SSN, in USA).
  """

  @doc """
  Formats a CPF value into CPF format. Returns a formatted `BrDocs.Doc`.

  Delegates the formatting to `BrDocs.CPF.Formatter.format/1`.
  """
  @spec format(String.t() | BrDocs.Doc.t()) :: BrDocs.Doc.t()
  defdelegate format(value), to: BrDocs.CPF.Formatter

  @doc """
  Validates a CPF value against CPF validation rules. Returns a boolean.

  Delegates the validation to `BrDocs.CPF.Validator.validate/1`.
  """
  @spec validate(String.t() | BrDocs.Doc.t()) :: BrDocs.Doc.t()
  defdelegate validate(value), to: BrDocs.CPF.Validator

  @doc """
  Used mostly for testing, yet you can generate a valid CPF. Returns a `BrDocs.Doc`.

  Delegates the generation to `BrDocs.CPF.Generator.generate/1`.
  """
  @spec generate(keyword()) :: BrDocs.Doc.t()
  defdelegate generate(opts \\ [formatted: false]), to: BrDocs.CPF.Generator
end
