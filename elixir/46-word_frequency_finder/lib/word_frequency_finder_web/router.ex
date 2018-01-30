defmodule WordFrequencyFinderWeb.Router do
  use WordFrequencyFinderWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WordFrequencyFinderWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/word-counter", WordCounterController, only: [:index, :show, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", WordFrequencyFinderWeb do
  #   pipe_through :api
  # end
end
