defmodule SmartcitydogsWeb.MySignalControllerAPI do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignal

  def index(conn, _params) do
    user = conn.private.plug_session["current_user_id"]
    signals = DataSignal.get_user_signal(user)
    render(conn, "index.json", signals: signals)
  end
end
