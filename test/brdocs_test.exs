defmodule BrDocsTest do
  use ExUnit.Case, async: true

  describe to_string(__MODULE__) do
    test "generate cpf" do
      assert BrDocs.generate(:cpf)
    end
  end
end
