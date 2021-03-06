defmodule Herework.Router do
  use Herework.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_session do
    plug :fetch_session
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  scope "/", Herework do
    pipe_through [:browser, :browser_session] # Use the default browser stack

    get "/", PageController, :index
    get "/join", JoinController, :index
    post "/join", JoinController, :create

    get "/login", SessionController, :index
    post "/login", SessionController, :create
    delete "/login", SessionController, :delete
  end

  scope "/api", Herework do
    pipe_through [:api, :api_session]

    resources "/app", AppController, except: [:new, :edit]
    resources "/messages", MessageController, except: [:new, :edit] do
      resources "/comments", CommentController, except: [:new, :edit]
    end
    resources "/users", UserController, except: [:new, :edit, :create, :update]
  end
end
