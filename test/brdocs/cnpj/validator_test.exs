defmodule BrDocs.CNPJ.ValidatorTest do
  use ExUnit.Case, async: true

  alias BrDocs.Doc

  defp validate_cnpj_struct(value) do
    BrDocs.CNPJ.Validator.validate(%Doc{kind: :cnpj, value: value})
  end

  describe to_string(__MODULE__) do
    test "valid cnpj" do
      assert validate_cnpj_struct("11444777000161")
      assert validate_cnpj_struct("11.444.777/0001-61")
    end

    test "invalid cnpj" do
      refute validate_cnpj_struct("11444777000162")
      refute validate_cnpj_struct("11.444.777/0001-62")
    end

    test "invalidate anything else than cnpj struct" do
      refute validate_cnpj_struct("")
      refute validate_cnpj_struct(nil)
      refute validate_cnpj_struct(123)
      refute validate_cnpj_struct("123")

      refute BrDocs.CNPJ.Validator.validate("")
      refute BrDocs.CNPJ.Validator.validate(nil)
      refute BrDocs.CNPJ.Validator.validate(123)
      refute BrDocs.CNPJ.Validator.validate("123")
    end
  end
end
