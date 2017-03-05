defmodule DPW.Vote do
  use DPW.Web, :model

  schema "votes" do
    field :direction, :boolean, default: false
    field :fingerprint, :string
    belongs_to :problem, DPW.Problem

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:direction, :fingerprint])
    |> validate_required([:direction, :fingerprint])
  end

  def create!(problem, direction, fingerprint \\ "FINGERPRINT_PLACEHOLDER") do 
    changeset = changeset(%__MODULE__{}, %{direction: direction, fingerprint: fingerprint})
    |> put_assoc(:problem, problem)

    {:ok, changeset}
  end
end
