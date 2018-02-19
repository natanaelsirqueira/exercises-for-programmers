defmodule MovieRecommendationsWeb.Router do
  use MovieRecommendationsWeb, :router

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

  scope "/", MovieRecommendationsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/movie-recommendations", MovieSearchController, :index
    post "/movie-recommendations/search", MovieSearchController, :search

    get "/movie-recommendations/movie/:imdbID", MovieController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MovieRecommendationsWeb do
  #   pipe_through :api
  # end
end
