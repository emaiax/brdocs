defmodule BrDocs.CPF.GeneratorTest do
  use ExUnit.Case, async: true

  alias BrDocs.Doc

  describe to_string(__MODULE__) do
    test "generate unformatted cpf" do
      %Doc{kind: :cpf, value: cpf} = BrDocs.CPF.Generator.generate()

      assert Regex.match?(~r/\d{11}/, cpf)
    end

    test "generate formatted cpf" do
      %Doc{kind: :cpf, value: cpf} = BrDocs.CPF.Generator.generate(formatted: true)

      assert Regex.match?(~r/\d{3}.\d{3}.\d{3}-\d{2}/, cpf)
    end
  end
end
