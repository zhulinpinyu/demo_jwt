defmodule DemoJwt.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias DemoJwt.Auth.User


  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :username, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :email])
    |> validate_required([:username, :password_hash, :email])
  end
end
