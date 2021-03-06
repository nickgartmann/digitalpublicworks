defmodule DPW.Router do
  use DPW.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DPW.Plugs.Meta
    plug DPW.Plugs.Auth
    plug DPW.Plugs.Analytics
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DPW do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/contact", PageController, :contact
    get "/privacy", PageController, :privacy
    get "/terms", PageController, :terms
    get "/submit", PageController, :submit

    get "/login", SessionController, :login
    post "/login", SessionController, :test_login
    get "/register", SessionController, :register
    post "/register", SessionController, :create_user
    get "/logout", SessionController, :logout

    get "/settings", PageController, :settings

    get "/problem/:id", PageController, :problem
    get "/problem/:id/vote/:direction", PageController, :cast_vote

    post "/form-submit", PageController, :respond
    get "/submission-thank-you", PageController, :thanks
    get "/contact-thank-you", PageController, :contact_thanks
    get "/problem-thank-you", PageController, :problem_thanks

    # Admin Routes
    get "/admin", AdminController, :index

    get "/admin/responses", AdminController, :response_types
    get "/admin/responses/:key", AdminController, :responses
    get "/admin/response/:id", AdminController, :response

    get "/admin/new-project", AdminController, :new_project
    post "/admin/new-project", AdminController, :create_project
  end

end
