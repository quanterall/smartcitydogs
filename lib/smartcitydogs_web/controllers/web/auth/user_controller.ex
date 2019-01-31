defmodule SmartcitydogsWeb.UserController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.Guardian
  alias SmartcitydogsWeb.Encoder

  def show(conn, _) do
    data =
      Guardian.Plug.current_resource(conn)
      |> Encoder.struct_to_map()

    json(conn, data)
  end
end
