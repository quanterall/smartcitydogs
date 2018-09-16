defmodule SmartcitydogsWeb.MySignalsControllerAPI do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals

  def index(conn, _params) do
    user = conn.private.plug_session["current_user_id"]
    signals = DataSignals.get_user_signal(user)
    render(conn, "index.json", signals: signals)
  end
end
