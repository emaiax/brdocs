defmodule BrDocs.CNPJ do
  defdelegate format(cnpj), to: BrDocs.CNPJ.Formatter
  defdelegate validate(cnpj), to: BrDocs.CNPJ.Validator
  defdelegate generate(opts \\ [formatted: false]), to: BrDocs.CNPJ.Generator
end
