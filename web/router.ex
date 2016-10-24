defmodule Herework.Router do
  use Herework.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", Herework do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/join", JoinController, :index
    post "/join", JoinController, :create
  end

  scope "/api", Herework do
    pipe_through :api

    resources "/app", AppController, except: [:new, :edit]
    resources "/messages", MessageController, except: [:new, :edit] do
      resources "/comments", CommentController, except: [:new, :edit]
    end
    resources "/users", UserController, except: [:new, :edit, :create, :update]
  end
end
