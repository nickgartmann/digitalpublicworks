defmodule DPW.User do
  use DPW.Web, :model

  schema "users" do
    field :email_address, :string
    field :encrypted_password, :string
    field :password_reset_token, :string
    field :roles, {:array, :string}

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email_address, :encrypted_password, :password_reset_token, :roles])
    |> validate_required([:email_address, :encrypted_password, :roles])
  end

  def create(params) do 
    params = params
      |> Map.put(:encrypted_password, crypt(params[:password]))
      |> Map.put(:roles, ["user"])
      |> Map.drop([:password])
    changeset(%__MODULE__{}, params)
  end

  def by_email(email) do
    by_email(__MODULE__, email)
  end

  def by_email(queryable, email) do
    queryable
    |> where([u], u.email_address == ^email)
    |> limit(1)
  end

  def is_admin?(%DPW.User{roles: roles}) do
    Enum.any?(roles, fn(role) -> role == "admin" end)
  end

  def crypt(pass) do
    Comeonin.Bcrypt.hashpwsalt(pass)
  end

  def check_password(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.encrypted_password)  
  end

end

