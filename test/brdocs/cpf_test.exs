defmodule BrDocs.CPFTest do
  use ExUnit.Case, async: true

  test "cpf is generated" do
    assert BrDocs.CPF.generate()
  end

  test "cpf is formatted" do
    assert BrDocs.CPF.format("123")
  end

  test "cpf is validated" do
    assert BrDocs.CPF.validate("12345678909")
    refute BrDocs.CPF.validate("12345678900")
  end
end
