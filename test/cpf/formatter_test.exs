defmodule BrDocs.CPF.FormatterTest do
  use ExUnit.Case, async: true

  defp formatted_cpf_struct(value) do
    %BrDoc{kind: :cpf, value: value} |> BrDocs.CPF.Formatter.format()
  end

  describe to_string(__MODULE__) do
    test "format raw cpf" do
      assert formatted_cpf_struct("11144477735") == %BrDoc{kind: :cpf, value: "111.444.777-35"}
    end

    test "format already formatted cpf" do
      assert formatted_cpf_struct("111.444.777-35") == %BrDoc{kind: :cpf, value: "111.444.777-35"}
    end

    test "doesn't format anything else than a valid cpf struct" do
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
end
