defmodule ElixirExperimentsWeb.Router do
  use ElixirExperimentsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ElixirExperimentsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirExperimentsWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/candles", CandleLive.Index, :index
    live "/candles/new", CandleLive.Index, :new
    live "/candles/:id/edit", CandleLive.Index, :edit

    live "/candles/:id", CandleLive.Show, :show
    live "/candles/:id/show/edit", CandleLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirExperimentsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ElixirExperimentsWeb.Telemetry
    end
  end
end
