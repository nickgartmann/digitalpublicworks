defmodule DPW.Response do
  use DPW.Web, :model

  schema "responses" do
    field :form_key, :string
    field :answers, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:form_key, :answers])
    |> validate_required([:form_key, :answers])
  end
end
