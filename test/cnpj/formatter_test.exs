defmodule BrDocs.CNPJ.FormatterTest do
  use ExUnit.Case, async: true

  defp formatted_cnpj_struct(value) do
    %BrDoc{kind: :cnpj, value: value} |> BrDocs.CNPJ.Formatter.format()
  end

  describe to_string(__MODULE__) do
    test "format raw cnpj" do
      assert formatted_cnpj_struct("11444777000161") == %BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}
    end

    test "format already formatted cnpj" do
      assert formatted_cnpj_struct("11.444.777/0001-61") == %BrDoc{kind: :cnpj, value: "11.444.777/0001-61"}
    end

    test "doesn't format anything else than a valid cnpj struct" do
      assert formatted_cnpj_struct("") == %BrDoc{kind: :cnpj, value: ""}
      assert formatted_cnpj_struct(nil) == %BrDoc{kind: :cnpj, value: ""}
      assert formatted_cnpj_struct(123) == %BrDoc{kind: :cnpj, value: "123"}
      assert formatted_cnpj_struct("123") == %BrDoc{kind: :cnpj, value: "123"}

      assert BrDocs.CNPJ.Formatter.format("") == %BrDoc{kind: :cnpj, value: ""}
      assert BrDocs.CNPJ.Formatter.format(nil) == %BrDoc{kind: :cnpj, value: ""}
      assert BrDocs.CNPJ.Formatter.format(123) == %BrDoc{kind: :cnpj, value: "123"}
      assert BrDocs.CNPJ.Formatter.format("123") == %BrDoc{kind: :cnpj, value: "123"}
    end
  end
end
