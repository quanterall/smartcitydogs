defmodule SmartcitydogsWeb.MySignalsControllerAPI do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals

  def index(conn, _params) do

    user = conn.private.plug_session["current_user_id"]
    sorted_signals = DataSignals.sort_signal_by_id()
    signals = DataSignals.get_user_signal(user)
    
    render(conn, "index.json", signals: signals)
  end
end
