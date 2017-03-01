defmodule DPW.Router do
  use DPW.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
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

    get "/login", PageController, :login

    get "/problem/:id", PageController, :problem
  end

  # Other scopes may use custom stacks.
  # scope "/api", DPW do
  #   pipe_through :api
  # end
end
