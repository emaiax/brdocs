defmodule BrDocs.CNPJTest do
  use ExUnit.Case, async: true

  test "cnpj is generated" do
    assert BrDocs.CNPJ.generate
  end

  test "cnpj is formatted" do
    assert BrDocs.CNPJ.format("123")
  end

  test "cnpj is validated" do
    assert BrDocs.CNPJ.validate("11444777000161")
    refute BrDocs.CNPJ.validate("11444777000160")
  end
end
