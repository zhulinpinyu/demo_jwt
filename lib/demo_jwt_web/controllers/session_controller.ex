defmodule DemoJwtWeb.SessionController do
  use DemoJwtWeb, :controller
  alias DemoJwt.Auth

  def create(conn, params) do
    case authenticate(params) do
      {:ok, user} ->
        new_conn = DemoJwt.Guardian.Plug.sign_in(conn, user)
        jwt = DemoJwt.Guardian.Plug.current_token(new_conn)
        new_conn
        |> put_status(:created)
        |> render("show.json", user: user, jwt: jwt)
      :error ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json")
    end
  end

  def delete(conn, _) do
    token = DemoJwt.Guardian.Plug.current_token(conn)
    DemoJwt.Guardian.revoke(token)
    conn
    |> put_status(:ok)
    |> render("delete.json")
  end

  def refresh(conn, _) do
    user = DemoJwt.Guardian.Plug.current_resource(conn)
    token = DemoJwt.Guardian.Plug.current_token(conn)
    case DemoJwt.Guardian.refresh(token) do
      {:ok, _old_stuff, {new_token, _new_claims}} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user, jwt: new_token)
      {:error, _} ->
        conn
        |> put_status(:unauthorized)
        |> render("forbidden.json", error: "Not Authenticated!")
     end
  end

  def unauthenticate(conn, _) do
    conn
    |> put_status(:forbidden)
    |> render(DemoJwt.SessionView, "forbidden.json", error: "Not Authenticated!")
  end

  defp authenticate(%{"email" => email, "password" => password}) do
    user = Auth.get_by(email: email)
    case check_password(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> Comeonin.Bcrypt.dummy_checkpw()
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end
end