defmodule BrDocs do
  # Generation
  def generate(kind, opts \\ [formatted: false])

  def generate(:cpf, opts), do: BrDocs.CPF.generate(opts)
  def generate(:cnpj, opts), do: BrDocs.CNPJ.generate(opts)

  # Formatting
  def format(value, :cpf), do: BrDocs.CPF.Formatter.format(value)
  def format(value, :cnpj), do: BrDocs.CNPJ.Formatter.format(value)

  def format(%BrDoc{kind: :cpf} = cpf), do: BrDocs.CPF.Formatter.format(cpf)
  def format(%BrDoc{kind: :cnpj} = cnpj), do: BrDocs.CNPJ.Formatter.format(cnpj)

  # Validation
  def validate(value, :cpf), do: BrDocs.CPF.Validator.validate(value)
  def validate(value, :cnpj), do: BrDocs.CNPJ.Validator.validate(value)

  def validate(%BrDoc{kind: :cpf} = cpf), do: BrDocs.CPF.Validator.validate(cpf)
  def validate(%BrDoc{kind: :cnpj} = cnpj), do: BrDocs.CNPJ.Validator.validate(cnpj)
end
