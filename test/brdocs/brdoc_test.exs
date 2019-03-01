defmodule BrDocs.DocTest do
  use ExUnit.Case, async: true

  test "available docs" do
    assert "`:cpf`, `:cnpj`" == BrDocs.Doc.formatted_available_docs()
  end
end
