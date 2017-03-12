defmodule DPW.SessionController do
  use DPW.Web, :controller

  alias DPW.{Repo, User}

  def login(conn, _params) do
    render conn, "login.html"
  end

  def register(conn, _params) do
    render conn, "register.html"
  end

  def test_login(conn, %{"email" => email, "password" => password}) do

    user = case User.by_email(email) |> Repo.one() do
      nil  -> conn |> put_flash(:error, "Invalid email or password") |> redirect(to: "/login")
      user -> user
    end

    case User.check_password(user, password) do
      false -> conn |> put_flash(:error, "Invalid email or password") |> redirect(to: "/login")
      true -> set_session(conn, user) |> redirect(to: "/")
    end

  end


  # Handle all cases of registration
  def registration_error(conn, key, message) do
    conn
    |> assign(:email, conn.params["email"])
    |> put_flash(key, message)
    |> render("register.html")
  end

  def create_user(conn, %{"password" => ""}), do: registration_error(conn, :password, "Cannot be blank")
  def create_user(conn, %{"password" => password, "password-confirm" => confirm})  when password != confirm do
    registration_error(conn, :password_confirm, "Must match password")
  end

  def create_user(conn, %{"email" => email, "password" => password, "password-confirm" => confirm}) do
    case User.by_email(email) |> Repo.one() do 
      user when not is_nil(user) -> registration_error(conn, :email, "Already in use")
      nil ->
        case User.create(%{email_address: email, password: password}) |> Repo.insert! do
          nil  -> put_flash(conn, :error, "Something went wrong, please contact support") |> redirect(to: "/register")
          user -> set_session(conn, user) |> redirect(to: "/")
        end
        # TODO: create the user
        redirect(conn, to: "/")
    end
  end

  defp set_session(conn, user) do
    conn
    |> set_encrypted_cookie("dpwsession", user.id)
  end

end

