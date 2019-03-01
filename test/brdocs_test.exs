defmodule BrDocsTest do
  use ExUnit.Case, async: true

  alias BrDocs.Doc

  describe "docs generation" do
    test "generate cpf" do
      assert Regex.match?(~r/\d{11}/, BrDocs.generate(:cpf).value)

      assert Regex.match?(
               ~r/\d{3}.\d{3}.\d{3}-\d{2}/,
               BrDocs.generate(:cpf, formatted: true).value
             )
    end

    test "generate cnpj" do
      assert Regex.match?(~r/\d{14}/, BrDocs.generate(:cnpj).value)

      assert Regex.match?(
               ~r/\d{2}.\d{3}.\d{3}\/\d{4}-\d{2}/,
               BrDocs.generate(:cnpj, formatted: true).value
             )
    end
  end

  describe "docs formatting" do
    test "format raw cpf" do
      assert "123.456.789-09" == BrDocs.format("12345678909", :cpf).value
    end

    test "format cpf struct" do
      assert "123.456.789-09" == BrDocs.format(%Doc{kind: :cpf, value: "12345678909"}).value
    end

    test "format raw cnpj" do
      assert "11.444.777/0001-61" == BrDocs.format("11444777000161", :cnpj).value
    end

    test "format cnpj struct" do
      assert "11.444.777/0001-61" ==
               BrDocs.format(%Doc{kind: :cnpj, value: "11444777000161"}).value
    end
  end

  describe "docs validation" do
    test "validate raw cpf" do
      assert BrDocs.validate("12345678909", :cpf)
      refute BrDocs.validate("12345678900", :cpf)

      assert BrDocs.validate("123.456.789-09", :cpf)
      refute BrDocs.validate("123.456.789-00", :cpf)
    end

    test "validate cpf struct" do
      assert BrDocs.validate(%Doc{kind: :cpf, value: "12345678909"})
      refute BrDocs.validate(%Doc{kind: :cpf, value: "12345678900"})

      assert BrDocs.validate(%Doc{kind: :cpf, value: "123.456.789-09"})
      refute BrDocs.validate(%Doc{kind: :cpf, value: "123.456.789-00"})
    end

    test "validate raw cnpj" do
      assert BrDocs.validate("11444777000161", :cnpj)
      refute BrDocs.validate("11444777000160", :cnpj)

      assert BrDocs.validate("11.444.777/0001-61", :cnpj)
      refute BrDocs.validate("11.444.777/0001-60", :cnpj)
    end

    test "validate cnpj struct" do
      assert BrDocs.validate(%Doc{kind: :cnpj, value: "11444777000161"})
      refute BrDocs.validate(%Doc{kind: :cnpj, value: "11444777000160"})

      assert BrDocs.validate(%Doc{kind: :cnpj, value: "11.444.777/0001-61"})
      refute BrDocs.validate(%Doc{kind: :cnpj, value: "11.444.777/0001-60"})
    end
  end
end
