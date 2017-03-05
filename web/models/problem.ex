defmodule DPW.Problem do
  use DPW.Web, :model

  schema "problems" do
    field :title, :string
    field :description, :string
    field :needs, :string
    field :featured, :boolean, default: false

    has_many :votes, DPW.Vote

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :needs, :featured])
    |> validate_required([:title, :description, :needs, :featured])
  end

  def featured(query \\ __MODULE__) do
    query 
    |> where([p], p.featured == true)
  end

end
