defmodule DemoJwt.Guardian.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :demo_jwt,
                              module: DemoJwt.Guardian,
                              error_handler: DemoJwt.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}, realm: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: true
end