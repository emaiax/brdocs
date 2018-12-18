defmodule BrDocs do
  def generate(kind, opts \\ [formatted: false])

  def generate(:cpf, opts), do: BrDocs.CPF.generate(opts)
  # def generate(:cnpj, opts), do: CNPJ.generate(opts)
end
