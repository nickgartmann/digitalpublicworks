defmodule DPW.Event do
  use DPW.Web, :model

  schema "events" do
    field :identifier, :string
    field :method, :string
    field :path, :string
    field :query, :string
    field :user_agent, :string
    field :ip, :string
    field :meta, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:identifier, :method, :path, :query, :user_agent, :ip, :meta])
    |> validate_required([:identifier, :method, :path, :ip])
  end

  def track(event) do 
    GenServer.cast(DPW.EventPersister, {:track, event})
  end
end
