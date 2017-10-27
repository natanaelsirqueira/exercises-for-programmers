defmodule WebsiteGeneratorWeb.Router do
  use WebsiteGeneratorWeb, :router

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

  scope "/", WebsiteGeneratorWeb do
    pipe_through :browser # Use the default browser stack

    resources "/", PageController, only: [:index]
    resources "/generate", GeneratorController, only: [:index, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebsiteGeneratorWeb do
  #   pipe_through :api
  # end
end
