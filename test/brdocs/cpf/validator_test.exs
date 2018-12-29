defmodule BrDocs.CPF.ValidatorTest do
  use ExUnit.Case, async: true

  alias BrDocs.BrDoc

  defp validate_cpf_struct(value) do
    BrDocs.CPF.Validator.validate(%BrDoc{kind: :cpf, value: value})
  end

  describe to_string(__MODULE__) do
    test "valid cpf" do
      assert validate_cpf_struct("11144477735")
      assert validate_cpf_struct("111.444.777-35")
    end

    test "invalid cpf" do
      refute validate_cpf_struct("12345678900")
      refute validate_cpf_struct("123.456.789-00")
    end

    test "invalidate anything else than cpf struct" do
      refute validate_cpf_struct("")
      refute validate_cpf_struct(nil)
      refute validate_cpf_struct(123)
      refute validate_cpf_struct("123")

      refute BrDocs.CPF.Validator.validate("")
      refute BrDocs.CPF.Validator.validate(nil)
      refute BrDocs.CPF.Validator.validate(123)
      refute BrDocs.CPF.Validator.validate("123")
    end
  end
end
