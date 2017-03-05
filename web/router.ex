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
    get "/problem/:id/vote/:direction", PageController, :cast_vote

    post "/form-submit", PageController, :respond
    get "/submission-thank-you", PageController, :thanks
    get "/contact-thank-you", PageController, :contact_thanks
    get "/problem-thank-you", PageController, :problem_thanks

    get "/responses/:key", PageController, :responses
    get "/response/:id", PageController, :response
  end

end
