defmodule BrDocs.BrDocTypeTest do
  use ExUnit.Case, async: true

  import BrDocs.BrDoc

  defmodule User do
    use Ecto.Schema

    import Ecto.Changeset
    import BrDocs.Changeset

    schema "users" do
      field :name, :string
      field :document, BrDocs.BrDoc.Type
    end

    def changeset(attrs) do
      struct!(__MODULE__, []) |> cast(attrs, [:name, :document])
    end
  end

  test "ecto type" do
    # BrDoc casting
    assert User.changeset(%{name: "eduardo", document: BrDocs.generate(:cpf)}).valid?

    # map casting
    assert User.changeset(%{name: "eduardo", document: %{kind: :cpf, value: "123"}}).valid?
  end
end
