defmodule InfiniteScrollWeb.Router do
  use InfiniteScrollWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {InfiniteScrollWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", InfiniteScrollWeb do
    pipe_through :browser

    # get "/", PageController, :index

    live "/", HomeLive.Index, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", InfiniteScrollWeb do
  #   pipe_through :api
  # end
end
