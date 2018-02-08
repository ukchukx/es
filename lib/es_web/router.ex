defmodule EsWeb.Router do
  use EsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", EsWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/", PageController, :handle_command
    get "/details", PageController, :detail
  end
end
