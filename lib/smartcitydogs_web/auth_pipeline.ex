defmodule Smartcitydogs.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :smartcitydogs,
    module: Smartcitydogs.Guardian,
    error_handler: Smartcitydogs.ApiAuthErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
