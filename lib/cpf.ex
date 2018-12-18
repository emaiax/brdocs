defmodule BrDocs.CPF do
  defdelegate format(cpf), to: BrDocs.CPF.Formatter
  defdelegate validate(cpf), to: BrDocs.CPF.Validator
  defdelegate generate(opts \\ [formatted: false]), to: BrDocs.CPF.Generator
end
