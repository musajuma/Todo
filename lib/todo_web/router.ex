defmodule TodoWeb.Router do
  use TodoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TodoWeb.Plugs.CurrentUser

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/signup", RegistrationController, only: [:new, :create]

    get "/signup", RegistrationController, :new

    resources "/signin", SessionController, only: [:new, :create]
    get "/signout", SessionController, :delete
    get "/signin", SessionController, :new
    get "/confirm", SessionController, :confirm
    get "/sign_out", SessionController, :delete

    resources "/todos", TodoController do
      resources "/items", ItemController, only: [:create]
    end



  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoWeb do
  #   pipe_through :api
  # end
end
