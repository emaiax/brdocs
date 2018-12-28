defmodule BrDocs.CPF do
  @moduledoc ~S"""
  Generation, validation and formatting for Brazilian CPF.

  In Brazil, the CPF is an unique 11 numbers length which identifies an individual (like SSN, in USA).
  """

  @doc """
  Formats a CPF value into CPF format. Returns a formatted `BrDocs.BrDoc`.

  Delegates the formatting to `BrDocs.CPF.Formatter.format/1`.
  """
  defdelegate format(cpf), to: BrDocs.CPF.Formatter

  @doc """
  Validates a CPF value against CPF validation rules. Returns a boolean.

  Delegates the validation to `BrDocs.CPF.Validator.validate/1`.
  """
  defdelegate validate(cpf), to: BrDocs.CPF.Validator

  @doc """
  Used mostly for testing, yet you can generate a valid CPF. Returns a `BrDocs.BrDoc`.

  Delegates the generation to `BrDocs.CPF.Generator.generate/1`.
  """
  defdelegate generate(opts \\ [formatted: false]), to: BrDocs.CPF.Generator
end
