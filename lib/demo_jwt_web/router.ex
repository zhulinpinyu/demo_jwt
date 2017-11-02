defmodule DemoJwtWeb.Router do
  use DemoJwtWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DemoJwtWeb do
    pipe_through :api
  end
end
