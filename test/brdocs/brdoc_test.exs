defmodule BrDocs.BrDocTest do
  use ExUnit.Case, async: true

  test "available docs" do
    assert "`:cpf`, `:cnpj`" == BrDocs.BrDoc.formatted_available_docs
  end
end
