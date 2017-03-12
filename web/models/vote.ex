defmodule DPW.Vote do
  use DPW.Web, :model

  schema "votes" do
    field :direction, :boolean, default: false
    field :fingerprint, :string
    belongs_to :problem, DPW.Problem
    belongs_to :user, DPW.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:direction])
    |> validate_required([:direction])
  end

  def create!(problem, user, direction) do 
    changeset = changeset(%__MODULE__{}, %{direction: direction})
    |> put_assoc(:problem, problem)
    |> put_assoc(:user, user)
  end
  
  def update!(vote, direction) do
    changeset(vote, %{direction: direction})
  end
end
