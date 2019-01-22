defmodule BrDocs.CPF.FormatterTest do
  use ExUnit.Case, async: true

  alias BrDocs.BrDoc

  defp stripped_cpf_struct(value) do
    BrDocs.CPF.Formatter.strip(%BrDoc{kind: :cpf, value: value})
  end

  defp formatted_cpf_struct(value) do
    BrDocs.CPF.Formatter.format(%BrDoc{kind: :cpf, value: value})
  end

  describe "format" do
    test "a raw cpf" do
      assert formatted_cpf_struct("11144477735") == %BrDoc{kind: :cpf, value: "111.444.777-35"}
    end

    test "an already formatted cpf" do
      assert formatted_cpf_struct("111.444.777-35") == %BrDoc{kind: :cpf, value: "111.444.777-35"}
    end

    test "invalid BrDocs.CPF" do
      assert formatted_cpf_struct("") == %BrDoc{kind: :cpf, value: ""}
      assert formatted_cpf_struct(nil) == %BrDoc{kind: :cpf, value: ""}
      assert formatted_cpf_struct(123) == %BrDoc{kind: :cpf, value: "123"}
      assert formatted_cpf_struct("123") == %BrDoc{kind: :cpf, value: "123"}

      assert BrDocs.CPF.Formatter.format("") == %BrDoc{kind: :cpf, value: ""}
      assert BrDocs.CPF.Formatter.format(nil) == %BrDoc{kind: :cpf, value: ""}
      assert BrDocs.CPF.Formatter.format(123) == %BrDoc{kind: :cpf, value: "123"}
      assert BrDocs.CPF.Formatter.format("123") == %BrDoc{kind: :cpf, value: "123"}
    end
  end

  describe "strip" do
    test "a raw cpf" do
      assert stripped_cpf_struct("11144477735") == %BrDoc{kind: :cpf, value: "11144477735"}
    end

    test "an already formatted cpf" do
      assert stripped_cpf_struct("111.444.777-35") == %BrDoc{kind: :cpf, value: "11144477735"}
    end

    test "invalid BrDocs.CPF" do
      assert stripped_cpf_struct("") == %BrDoc{kind: :cpf, value: ""}
      assert stripped_cpf_struct(nil) == %BrDoc{kind: :cpf, value: ""}
      assert stripped_cpf_struct(123) == %BrDoc{kind: :cpf, value: "123"}
      assert stripped_cpf_struct("123") == %BrDoc{kind: :cpf, value: "123"}

      assert BrDocs.CPF.Formatter.strip("") == %BrDoc{kind: :cpf, value: ""}
      assert BrDocs.CPF.Formatter.strip(nil) == %BrDoc{kind: :cpf, value: ""}
      assert BrDocs.CPF.Formatter.strip(123) == %BrDoc{kind: :cpf, value: "123"}
      assert BrDocs.CPF.Formatter.strip("123") == %BrDoc{kind: :cpf, value: "123"}
    end
  end
end
