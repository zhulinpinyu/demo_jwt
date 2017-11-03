defmodule DemoJwtWeb.Router do
  use DemoJwtWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug DemoJwt.Guardian.AuthAccessPipeline
  end

  scope "/api", DemoJwtWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create]
  end
end
