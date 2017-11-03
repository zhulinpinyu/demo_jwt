defmodule DemoJwtWeb.UserController do
  use DemoJwtWeb, :controller

  alias DemoJwt.Auth

  action_fallback DemoJwtWeb.FallbackController

  def create(conn, user_params) do
    case Auth.create_user(user_params) do
      {:ok, user} ->
        new_conn = DemoJwt.Guardian.Plug.sign_in(conn, user)
        jwt = DemoJwt.Guardian.Plug.current_token(new_conn)
        conn
        |> put_status(:created)
        |> render(DemoJwtWeb.SessionView, "show.json", user: user, jwt: jwt)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(DemoJwtWeb.SessionView, "error.json", changeset: changeset)
    end
  end
end
