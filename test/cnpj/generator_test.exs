defmodule BrDocs.CNPJ.GeneratorTest do
  use ExUnit.Case, async: true

  describe to_string(__MODULE__) do
    test "generate unformatted cnpj" do
      %BrDoc{kind: :cnpj, value: cnpj} = BrDocs.CNPJ.Generator.generate()

      assert Regex.match?(~r/\d{14}/, cnpj)
    end

    test "generate formatted cnpj" do
      %BrDoc{kind: :cnpj, value: cnpj} = BrDocs.CNPJ.Generator.generate(formatted: true)

      assert Regex.match?(~r/\d{2}.\d{3}.\d{3}\/\d{4}-\d{2}/, cnpj)
    end
  end
end
