if Code.ensure_loaded?(Ecto) do
  defmodule BrDocs.Changeset do
    @moduledoc """
    BrDocs validations to use with `Ecto.Changeset`

    Although `BrDocs` can be used as standalone lib, trying to use `BrDocs.Changeset` without `Ecto` installed will raise an exception.
    """

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
        use BrDocs.Changeset

        import Ecto.Changeset

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
    @spec validate_doc(Ecto.Changeset.t(), atom(), atom(), String.t() | nil) :: Ecto.Changeset.t()
    def validate_doc(changeset, field, kind, custom_message \\ nil) do
      with value <- Ecto.Changeset.get_change(changeset, field, ""),
           true <- BrDocs.validate(value, kind) do
        changeset
      else
        _ -> Ecto.Changeset.add_error(changeset, field, custom_message || "is invalid")
      end
    end
  end
end
