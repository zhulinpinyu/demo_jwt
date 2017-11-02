defmodule DemoJwtWeb.UserController do
  use DemoJwtWeb, :controller

  alias DemoJwt.Auth
  alias DemoJwt.Auth.User

  action_fallback DemoJwtWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end
end
