defmodule BrDocs.ChangesetTest do
  use ExUnit.Case, async: true

  import BrDocs.Changeset

  # default Ecto.Changeset structure
  #
  defp changeset_cast(changes) when is_map(changes) do
    %Ecto.Changeset{
      action: nil,
      changes: changes,
      errors: [],
      data: nil,
      valid?: true,
      types: %{doc: :string}
    }
  end

  describe "Validating CPF" do
    test "with an invalid doc" do
      changeset =
        %{doc: "1234"}
        |> changeset_cast()
        |> validate_doc(:doc, :cpf)

      refute changeset.valid?

      assert changeset.errors[:doc] == {"is invalid", []}
    end

    test "with an invalid doc and custom message" do
      changeset =
        %{doc: "1234"}
        |> changeset_cast()
        |> validate_doc(:doc, :cpf, "couldn't be validated")

      refute changeset.valid?

      assert changeset.errors[:doc] == {"couldn't be validated", []}
    end

    test "with an valid doc" do
      changeset =
        %{doc: "12345678909"}
        |> changeset_cast()
        |> validate_doc(:doc, :cpf)

      assert changeset.valid?
    end
  end

  describe "Validating CNPJ" do
    test "with an invalid doc" do
      changeset =
        %{doc: "1234"}
        |> changeset_cast()
        |> validate_doc(:doc, :cnpj)

      refute changeset.valid?

      assert changeset.errors[:doc] == {"is invalid", []}
    end

    test "with an invalid doc and custom message" do
      changeset =
        %{doc: "1234"}
        |> changeset_cast()
        |> validate_doc(:doc, :cnpj, "couldn't be validated")

      refute changeset.valid?

      assert changeset.errors[:doc] == {"couldn't be validated", []}
    end

    test "with an valid doc" do
      changeset =
        %{doc: "11444777000161"}
        |> changeset_cast()
        |> validate_doc(:doc, :cnpj)

      assert changeset.valid?
    end
  end
end
