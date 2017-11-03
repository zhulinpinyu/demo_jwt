defmodule DemoJwtWeb.SessionView do
  use DemoJwtWeb, :view

  alias DemoJwtWeb.UserView

  def render("show.json", %{user: user, jwt: jwt}) do
    %{
      data: render_one(user, UserView, "user.json"),
      meta: %{token: jwt}
    }
  end

  def render("error.json", _) do
    %{error: "username or password not correct."}
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("forbidden.json", %{error: error}) do
    %{error: error}
  end
end