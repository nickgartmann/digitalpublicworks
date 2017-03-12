defmodule DPW.Plugs.Admin do
  import Plug.Conn

  alias DPW.{User}

  def init(opts), do: opts

  def call(conn, _params) do
    case conn.assigns[:current_user] do
      nil -> reject(conn)
      user -> case User.is_admin?(user) do 
        true -> conn
        false -> reject(conn)
      end
    end
  end

  def reject(conn) do
    Phoenix.Controller.redirect(conn, to: "/") |> halt()
  end

end
