defmodule DemoJwt.Guardian do
  use Guardian, otp: :demo_jwt

  alias DemoJwt.Auth

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(claims) do
    {:ok, Auth.get_user!(claims["sub"])}
  end
end