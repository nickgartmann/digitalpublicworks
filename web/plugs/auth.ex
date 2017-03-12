defmodule DPW.Plugs.Auth do 
  import Plug.Conn
  
  alias DPW.{Repo, User}

  def init(opts), do: opts

  def call(conn, _params) do 
    user = case DPW.Helpers.get_encrypted_cookie(conn, "dpwsession") do
      nil -> nil
      id  -> Repo.get(User, id) 
    end
    conn
    |> assign(:current_user, user)
  end

end
