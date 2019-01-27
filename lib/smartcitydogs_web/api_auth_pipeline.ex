defmodule Smartcitydogs.Guardian.ApiAuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :smartcitydogs,
    module: Smartcitydogs.Guardian,
    error_handler: Smartcitydogs.ApiAuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
