defmodule Personal.Router do
  use Personal.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    #plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Personal do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/about", PageController, :index
    get "/resume", PageController, :resume
    get "/contact", PageController, :contact
    post "/contact", PageController, :send_contact_request
  end

  # Other scopes may use custom stacks.
  # scope "/api", Personal do
  #   pipe_through :api
  # end
end
