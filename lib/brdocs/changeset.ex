defmodule BrDocs.Changeset do
  @moduledoc """
    BrDocs validations to use with `Ecto.Changeset`
  """

  import Ecto.Changeset

  @doc ~s"""
  Validates a changeset against `BrDocs` validation rules. Returns an `Ecto.Changeset`.

  Arguments are:

  * `field` - is the changeset field to be validated
  * `kind` - is the `BrDocs.BrDoc` document kind which will identify the validation rule. It must be one of #{
    BrDocs.BrDoc.formatted_available_docs()
  }.

  ## Examples

      defmodule User do
        use Ecto.Schema
        import Ecto.Changeset
        import BrDocs.Changeset

        schema "users" do
          field :name
          field :brazilian_doc
        end

        def changeset(user, params \\\\ %{}) do
          user
          |> cast(params, [:name, :brazilian_doc])
          |> validate_required([:name, :brazilian_doc])
          |> validate_doc(:brazilian_doc, :cpf)
          |> unique_constraint(:brazilian_doc)
        end
      end
  """
  @spec validate_doc(Ecto.Changeset.t(), atom(), atom(), String.t()) :: Ecto.Changeset.t()
  def validate_doc(changeset, field, kind, custom_message \\ nil) do
    with value <- get_change(changeset, field, ""),
         true <- BrDocs.validate(value, kind) do
      changeset
    else
      _ -> add_error(changeset, field, custom_message || "is invalid")
    end
  end
end
